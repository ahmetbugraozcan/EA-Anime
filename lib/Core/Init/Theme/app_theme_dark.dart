import 'package:flutter/src/material/theme_data.dart';
import 'package:flutterglobal/Core/Init/Theme/i_app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeDark implements IAppTheme {
  static AppThemeDark _instance = AppThemeDark._init();
  static AppThemeDark get instance => _instance;

  AppThemeDark._init();

  @override
  ThemeData? themeData = ThemeData.dark().copyWith(
    textTheme: GoogleFonts.montserratTextTheme(),
  );
}
