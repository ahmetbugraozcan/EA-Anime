import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';

class SnackbarContent extends StatelessWidget {
  Icon icon;
  Color borderColor;
  String title;
  String subtitle;

  SnackbarContent(
      {Key? key,
      required this.icon,
      required this.borderColor,
      required this.title,
      required this.subtitle})
      : super(key: key);

  //Utils.buildsnackbar ile kullanılmalı
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
              stops: [0.02, 0.02], colors: [borderColor, Colors.white]),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: icon,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      style: context.textTheme.headline6
                          ?.copyWith(fontWeight: FontWeight.normal),
                    ),
                    Text(
                      subtitle,
                      style: context.textTheme.bodyMedium
                          ?.copyWith(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
