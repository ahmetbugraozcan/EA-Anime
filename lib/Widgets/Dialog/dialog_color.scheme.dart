import 'package:flutter/material.dart';
import 'package:flutterglobal/Widgets/Dialog/dialog_with_background.dart';

enum DialogEnums { INTERACTIVE, INFORMATION, ERROR }

// TODO text colorları da eklenecek
abstract class DialogColorScheme {
  Color backgroundColor;
  Color approvalButtonColor;
  Color cancelButtonColor;
  Color? approvalButtonTextColor;
  Color? cancelButtonTextColor;

  DialogColorScheme(
      {required this.backgroundColor,
      required this.approvalButtonColor,
      required this.cancelButtonColor});

  static DialogColorScheme getDialogColorScheme(DialogEnums enums) {
    switch (enums) {
      case DialogEnums.INFORMATION:
        return InformantionDialogColorScheme();
      case DialogEnums.ERROR:
        return ErrorDialogColorScheme();
      case DialogEnums.INTERACTIVE:
        return InformantionDialogColorScheme();
    }
  }
}

class ErrorDialogColorScheme implements DialogColorScheme {
  @override
  Color approvalButtonColor = Color(0xfff44336);

  @override
  Color backgroundColor = Color(0xfff6655a);

  @override
  Color cancelButtonColor = Colors.grey.shade200;

  @override
  Color? approvalButtonTextColor;

  @override
  Color? cancelButtonTextColor = Color(0xfff44336);
}

class InformantionDialogColorScheme implements DialogColorScheme {
  @override
  Color approvalButtonColor = Colors.grey.shade200;

  @override
  Color backgroundColor = Color(0xff4f91ff);

  @override
  Color cancelButtonColor = Color(0xff2979ff);

  @override
  Color? approvalButtonTextColor = Color(0xff4f91ff);

  @override
  Color? cancelButtonTextColor = Colors.grey.shade200;
}
