import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/network/dio_helper.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/auth/data/auth_repo/auth_repo.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/controller/home_screen_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/data/home_repo/home_repo.dart';
import 'package:kod_ghaseel_provider_app/firebase_options.dart';

import 'core/network/bloc_observer.dart';
import 'features/home_screen/tabs/profile_tab/controller/profile_cubit.dart';
import 'features/home_screen/tabs/profile_tab/data/repo/profile_repo.dart';
import 'generated/l10n.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await ensureFirebase();
  // FirebaseDatabase.instance.setPersistenceEnabled(true);
  log('Background message received:');
  log(
    '------------  new doc notification ${message.notification} -------------',
  );

  final type = message.notification?.android?.sound ?? 'notification';
  final androidDetails = AndroidNotificationDetails(
    'high_importance_channel_zeds_fares_note_$type',
    'High Importance Notifications',
    channelDescription: 'This channel is used for important notifications.',
    sound: RawResourceAndroidNotificationSound(
      type,
    ), // 'trip' or 'notification'
    importance: Importance.high,
    priority: Priority.high,
  );

  NotificationDetails(android: androidDetails);

  // await NotificationService.instance.showNotification(message);
}

void clearNotifications() async {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin.cancelAll();
}

Future<FirebaseApp> ensureFirebase({String? name}) async {
  try {
    if (name == null) {
      return Firebase.apps.isEmpty
          ? await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      )
          : Firebase.app();
    } else {
      return Firebase.apps.any((a) => a.name == name)
          ? Firebase.app(name)
          : await Firebase.initializeApp(
        name: name,
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      return name == null ? Firebase.app() : Firebase.app(name);
    }
    rethrow;
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  GoogleMapsFlutterAndroid().warmup();
  final myHttpOverrides = MyHttpOverrides();
  clearNotifications();
  HttpOverrides.global = myHttpOverrides;
  DioHelper.initialize();
  await AppSharedPreferences.init();

  await ensureFirebase();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeScreenCubit(HomeRepo())),
        BlocProvider(create: (_) => ProfileCubit(ProfileRepo())),
        BlocProvider(create: (_) => AuthCubit(AuthRepo())),
      ],
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return BlocBuilder<HomeScreenCubit, HomeScreenState>(
              builder: (context, state) {
                Locale currentLocale = const Locale('ar');

                if (state is HomeScreenLanguageLoaded) {
                  currentLocale = state.locale;
                } else if (state is HomeScreenLanguageChanged) {
                  currentLocale = state.locale;
                }

                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  locale: currentLocale,
                  theme: AppStyle.lightTheme,
                  darkTheme: AppStyle.darkTheme,
                  routerConfig: AppRouter.router,
                  themeMode: ThemeMode.light,
                  supportedLocales: const [Locale('ar'), Locale('en')],
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
