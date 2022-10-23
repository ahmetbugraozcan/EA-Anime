import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';

class StackedTextCard extends StatelessWidget {
  VoidCallback? onPressed;
  String? text;
  String imageUrl;

  StackedTextCard(
      {super.key, this.onPressed, this.text, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return BounceWithoutHover(
      duration: Duration(milliseconds: 100),
      onPressed: onPressed,
      child: Container(
        height: 200,
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(imageUrl),
          ),
        ),
        child: Container(
          width: double.infinity,
          color: Colors.black.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text ?? "",
                style: context.textTheme.headline6?.copyWith(
                  color: Colors.white,
                )),
          ),
        ),
      ),
    );
  }
}
