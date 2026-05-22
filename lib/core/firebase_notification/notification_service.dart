import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_action.dart';
import 'notifications_code.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  // ============================================================
  //                INITIALIZATION
  // ============================================================
  Future<void> initialize() async {
    if (_initialized) return;

    await setupFlutterNotifications();
    await _requestPermission();
    await _setupMessageHandlers();

    _initialized = true;
  }

  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // ============================================================
  //      LOCAL NOTIFICATION SETUP (Foreground & Background)
  // ============================================================
  Future<void> setupFlutterNotifications() async {
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/launcher_icon');

    const DarwinInitializationSettings iosSettings =
    DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        handleNotificationClick(response: response);
      },
    );

    const AndroidNotificationChannel mainChannel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'Main notification channel',
      importance: Importance.high,
      playSound: true,
    );

    const AndroidNotificationChannel silentChannel = AndroidNotificationChannel(
      'silent_channel',
      'Silent Notifications',
      description: 'Background status updates (no sound)',
      importance: Importance.low,
      playSound: false,
      enableVibration: false,
    );

    final androidPlugin =
    _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(mainChannel);
    await androidPlugin?.createNotificationChannel(silentChannel);
  }

  // ============================================================
  //                FOREGROUND / BACKGROUND HANDLERS
  // ============================================================
  StreamSubscription<RemoteMessage>? _msgSub;

  Future<void> _setupMessageHandlers() async {
    _msgSub?.cancel();

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // ========= FOREGROUND NOTIFICATIONS =========
    _msgSub = FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) log("🔥 Foreground message: ${message.data}");

      _handleNotificationActions(message);
      await showNotification(message: message);
    });

    // ========= USER TAPS BACKGROUND NOTIFICATION =========
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) log("🟢 onMessageOpenedApp: ${message.data}");
      handleNotificationClick(message: message);
    });

    // ========= TERMINATED APP =========
    final initialMsg = await _messaging.getInitialMessage();
    if (initialMsg != null) {
      if (kDebugMode) log("🟣 App opened from TERMINATED: ${initialMsg.data}");
      _handleNotificationActions(initialMsg);
    }
  }

  void _handleNotificationActions(RemoteMessage message) {
    final code = message.data['code'];
    if (code == null) return;

    final action = NotificationCode.fromCode(code);
    if (NotificationAction.notificationHandlers.containsKey(action)) {
      NotificationAction.notificationHandlers[action]!.call(message.data, message);
    } else if (kDebugMode) {
      log("⚠ Unhandled notification code: $code");
    }
  }

  // ============================================================
  //                SHOW NOTIFICATION
  // ============================================================
  Future<void> showNotification({required RemoteMessage message}) async {
    final notif = message.notification;
    // final android = notif?.android;

    if (notif == null) return;

    // Silent code 75
    if (message.data['code'] == '75') {
      const silentAndroid = AndroidNotificationDetails(
        'silent_channel',
        'Silent Notifications',
        importance: Importance.low,
        playSound: false,
        enableVibration: false,
        enableLights: false,
        icon: '@mipmap/launcher_icon',
      );

      const silentIOS = DarwinNotificationDetails(
        presentSound: false,
      );

      await _localNotifications.show(
        notif.hashCode,
        notif.title,
        notif.body,
        const NotificationDetails(android: silentAndroid, iOS: silentIOS),
        payload: jsonEncode(message.data),
      );
      return;
    }

    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'Main channel',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/launcher_icon',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final platformDetails = const NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      notif.hashCode,
      notif.title,
      notif.body,
      platformDetails,
      payload: jsonEncode(message.data),
    );
  }

  // ============================================================
  //                CLICK HANDLER
  // ============================================================
  void handleNotificationClick(
      {RemoteMessage? message, NotificationResponse? response}) {
    Map<String, dynamic>? data;

    if (response != null && response.payload != null) {
      data = jsonDecode(response.payload!);
    } else if (message != null) {
      data = message.data;
    }

    if (data == null) return;

    final code = data['code'];
    final action = NotificationCode.fromCode(code);

    if (NotificationAction.notificationHandlers.containsKey(action)) {
      NotificationAction.notificationHandlers[action]!.call(data, RemoteMessage(data: data));
    } else if (kDebugMode) {
      log("⚠ Unhandled click code: $code");
    }
  }

  Future<String?> getTokenFireBase(
      {int retries = 3, int delayMilliseconds = 1000}) async {
    try {
      await initialize();
      String? token;

      for (int attempt = 0; attempt < retries; attempt++) {
        token = await _messaging.getToken();
        if (kDebugMode) debugPrint('FCM Token obtained');

        if (token != null) {
          return token;
        } else {
          // If token is null, delay before retrying
          if (attempt < retries - 1) {
            await Future<void>.delayed(
                Duration(milliseconds: delayMilliseconds));
          }
        }
      }

      // Return empty string or null if the token could not be retrieved after retries
      return '';
    } on Exception {
      // Log the exception or handle it more effectively
      return ''; // Return empty string or null in case of an exception
    }
  }
}
