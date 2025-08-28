import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rakaan/rakaan_app.dart';
import 'core/di/di.dart';
import 'core/framework/app_firebase.dart';
import 'core/framework/bloc_observer.dart';
import 'core/framework/device_info.dart' as di;
import 'core/util/routing/app_router.dart';

/// Easy Localization
/// dart run easy_localization:generate -S assets/translations
/// dart run easy_localization:generate -f keys -o locale_keys.g.dart -S assets/translations

/// Di (InjectableInit)
/// dart run build_runner build --delete-conflicting-outputs

void main() async {
  // runZonedGuarded<Future<void>>(
  //       () async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (Platform.isIOS) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }
  HttpOverrides.global = MyHttpOverrides();
  await configureDependencies();
  await Future.wait([
    getIt<AppFirebase>().initializeFireBaseNotifications(),

    getIt<di.DeviceInfo>().init(),
    ScreenUtil.ensureScreenSize(),
    EasyLocalization.ensureInitialized(),
  ]);

  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Bloc.observer = MyBlocObserver();
  print("test fcm");
  print(await FirebaseMessaging.instance.getToken());
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        useOnlyLangCode: true,
        supportedLocales: const [
          Locale('ar'),
          Locale('en'),
        ],
        path: 'assets/translations',
        startLocale: const Locale('ar'),
        child: RakaanApp(
          appRouter: AppRouter(),
        ),
      ),
    ),
  );
  //   },
  //       (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  // );
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}