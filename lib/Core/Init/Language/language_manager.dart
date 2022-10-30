import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';

class LanguageManager {
  static LanguageManager? _instance;

  static LanguageManager get instance {
    return _instance ?? LanguageManager._init();
  }

  LanguageManager._init();

  final enLocale = Locale('en');
  final trLocale = Locale('tr');

  List<Locale> get supportedLocales => [trLocale, enLocale];

  Locale getLocale(LanguageEnums language) {
    switch (language) {
      case LanguageEnums.TR:
        return trLocale;
      case LanguageEnums.EN:
        return enLocale;
      default:
        return trLocale;
    }
  }
}
