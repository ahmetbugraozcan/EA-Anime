import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Constants/app_constants.dart';
import 'package:flutterglobal/Core/Init/Cache/locale_manager.dart';
import 'package:flutterglobal/Core/Init/Language/language_manager.dart';
import 'package:flutterglobal/Core/Init/Theme/app_theme_light.dart';
import 'package:flutterglobal/Provider/all_providers.dart';
import 'package:flutterglobal/Provider/language/cubit/language_provider_cubit.dart';
import 'package:flutterglobal/Service/FirebaseNotificationService/firebase_messaging_service.dart';
import 'package:flutterglobal/Service/PackageInfo/package_info.dart';
import 'package:flutterglobal/View/Splash/view/splash_view.dart';
import 'package:flutterglobal/firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: AppConstants.instance.LANG_ASSET_PATH,
      child: MultiBlocProvider(
        providers: [...AllProviders.instance.dependItems()],
        child: MyApp(),
      ),
    ),
  );
}

Future<void> initializeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessagingService.instance.initService();
  await FirebaseMessagingService.instance.initLocalNotifications();
  await EasyLocalization.ensureInitialized();
  await CacheManager.preferencesInit();
  await CacheManager.instance.setIntValue(PreferencesKeys.DOWNLOAD_COUNT, 2);
  await MobileAds.instance.initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await PackageInfoService.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LanguageProviderCubit>().getLanguage().then((value) => context
        .setLocale(context.read<LanguageProviderCubit>().state.currentLocale!));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      locale:
          BlocProvider.of<LanguageProviderCubit>(context).state.currentLocale,
      builder: DevicePreview.appBuilder,
      theme: AppThemeLight.instance.themeData,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: SplashView(),
    );
  }
}
