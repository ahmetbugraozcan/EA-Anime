import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  Future showSnackbar(
      {required String title,
      required Icon icon,
      required String subtitle,
      required Color borderColor,
      Duration? duration}) {
    return Flushbar(
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          offset: Offset(0.0, 0.0),
          blurRadius: 10.0,
        ),
      ],
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      flushbarPosition: FlushbarPosition.TOP,
      leftBarIndicatorColor: borderColor,
      backgroundColor: Colors.white,
      borderRadius: BorderRadius.circular(12),
      icon: icon,
      messageText: Text(
        subtitle,
        style: textTheme.bodyText1?.copyWith(color: Colors.grey.shade500),
      ),
      titleText: Text(
        title,
        style: textTheme.headline6?.copyWith(fontWeight: FontWeight.normal),
      ),
      duration: Duration(seconds: 3),
    ).show(this);
  }
}
