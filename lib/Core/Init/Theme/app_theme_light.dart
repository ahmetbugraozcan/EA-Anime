import 'package:flutter/src/material/theme_data.dart';
import 'package:flutterglobal/Core/Init/Theme/i_app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeLight implements IAppTheme {
  static AppThemeLight _instance = AppThemeLight._init();
  static AppThemeLight get instance => _instance;

  AppThemeLight._init();

  @override
  ThemeData? themeData = ThemeData.light().copyWith(
    textTheme: GoogleFonts.ubuntuTextTheme(),
  );
}
