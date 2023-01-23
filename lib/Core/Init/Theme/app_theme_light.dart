import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Init/Theme/i_app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeLight implements IAppTheme {
  static AppThemeLight _instance = AppThemeLight._init();
  static AppThemeLight get instance => _instance;

  AppThemeLight._init();

  @override
  ThemeData? themeData = ThemeData.light().copyWith(
    textTheme: GoogleFonts.ubuntuTextTheme(),
    useMaterial3: true,
    // primaryColor: Color(0xff2e3192),
    // primaryColorDark: Color(0xff2e3192),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: Color(0xff2e3192),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //   ),
    // ),
  );
}
