import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/app_constants.dart';
import 'package:flutterglobal/Core/Init/Cache/locale_manager.dart';
import 'package:flutterglobal/Core/Init/Language/language_manager.dart';
import 'package:flutterglobal/Core/Init/Theme/app_theme_light.dart';
import 'package:flutterglobal/Provider/all_providers.dart';
import 'package:flutterglobal/View/Splash/view/splash_view.dart';
import 'package:flutterglobal/firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await CacheManager.preferencesInit();
  await MobileAds.instance.initialize();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    EasyLocalization(
      supportedLocales: LanguageManager.instance.supportedLocales,
      path: AppConstants.instance.LANG_ASSET_PATH,
      child: DevicePreview(
        enabled: false,
        builder: (context) => MultiBlocProvider(
          providers: [...AllProviders.instance.dependItems()],
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      // locale: context.locale,

      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: AppThemeLight.instance.themeData,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      home: SplashView(),
    );
  }
}
