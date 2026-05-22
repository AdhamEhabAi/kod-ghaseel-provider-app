import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:kod_ghaseel_provider_app/Utilites/app_style/style.dart';
import 'package:kod_ghaseel_provider_app/core/firebase_notification/notification_service.dart';
import 'package:kod_ghaseel_provider_app/core/helpers/shared_prefrence.dart';
import 'package:kod_ghaseel_provider_app/core/network/dio_helper.dart';
import 'package:kod_ghaseel_provider_app/core/router/router.dart';
import 'package:kod_ghaseel_provider_app/features/auth/controller/auth_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/controller/home_screen_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/notification/controller/notification_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/orders/controller/orders_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/service_screen/controller/service_cubit.dart';
import 'package:kod_ghaseel_provider_app/features/statics/controller/statics_cubit.dart';
import 'package:kod_ghaseel_provider_app/firebase_options.dart';

import 'core/helpers/DI/Di.dart';
import 'core/network/bloc_observer.dart';
import 'features/home_screen/tabs/profile_tab/controller/profile_cubit.dart';
import 'generated/l10n.dart';

// SECURITY: MyHttpOverrides with badCertificateCallback has been removed.
// All SSL certificates are now validated properly in production.


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await ensureFirebase();
  log('Background message received:');
  log(
    '------------  new doc notification ${message.notification} -------------',
  );

  // Show notification using NotificationService
  await NotificationService.instance.showNotification(message: message);
}

Future<void> clearNotifications() async {
  try {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.cancelAll();
  } catch (e) {
    log('Error clearing notifications: $e');
    // Don't rethrow - allow app to continue
  }
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

  try {
    // Initialize Firebase (single, safe entry point)
    await ensureFirebase();
  } catch (e) {
    log('Firebase initialization error: $e');
    // Continue even if Firebase fails to prevent crash
  }
  if (kDebugMode) Bloc.observer = MyBlocObserver();
  if (Platform.isAndroid) {
    try {
      GoogleMapsFlutterAndroid().warmup();
    } catch (e) {
      log('Google Maps warmup error: $e');
    }
  }

  try {
    clearNotifications();
  } catch (e) {
    log('Error clearing notifications: $e');
  }

  DioHelper.initialize();
  await AppSharedPreferences.init();
  configureDependencies();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // NotificationService is initialised from HomeScreen after session validation
  // so that the rationale sheet is shown before the permission dialog.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HomeScreenCubit>()),
        BlocProvider(create: (_) => getIt<ProfileCubit>()),
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<ServiceCubit>()),
        BlocProvider(create: (_) => getIt<OrdersCubit>()),
        BlocProvider(create: (_) => getIt<StaticsCubit>()),
        BlocProvider(create: (_) => getIt<NotificationCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocBuilder<HomeScreenCubit, HomeScreenState>(
            buildWhen: (previous, current) =>
            current is HomeScreenLanguageLoaded ||
                current is HomeScreenLanguageChanged,
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
                // ✅ Safe place to override MediaQuery (now there *is* a MediaQuery above)
                builder: (context, child) {
                  final mediaQueryData = MediaQuery.of(context);
                  return MediaQuery(
                    data: mediaQueryData.copyWith(
                      textScaler: TextScaler.noScaling,
                    ),
                    child: child ?? const SizedBox.shrink(),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
