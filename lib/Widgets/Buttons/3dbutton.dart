import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';

class ThreeDButton extends StatelessWidget {
  const ThreeDButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BounceWithoutHover(
      onPressed: () {},
      duration: Duration(milliseconds: 100),
      child: Container(
        constraints: BoxConstraints(minWidth: 100, minHeight: 50),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 2),
            )
          ],
        ),
      ),
    );
  }
}
