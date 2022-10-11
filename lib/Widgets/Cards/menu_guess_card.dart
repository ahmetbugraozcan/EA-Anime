import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Constants/app_constants.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';

class MenuGuessCard extends StatelessWidget {
  String title;
  String subtitle;
  ImageEnums? background;
  VoidCallback? onPressed;
  BoxFit fit;
  MenuGuessCard(
      {super.key,
      required this.title,
      required this.subtitle,
      this.onPressed,
      this.fit = BoxFit.cover,
      this.background});

  @override
  Widget build(BuildContext context) {
    return BounceWithoutHover(
      onPressed: onPressed ?? null,
      duration: Duration(milliseconds: 150),
      child: Builder(builder: (context) {
        return Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * .1,
          ),
          width: double.infinity,
          padding: EdgeInsets.all(24),
          margin: EdgeInsets.all(12),
          foregroundDecoration: onPressed == null
              ? BoxDecoration(
                  color: Colors.grey,
                  backgroundBlendMode: BlendMode.saturation,
                )
              : null,
          decoration: Utils.instance
              .backgroundDecoration(background ?? ImageEnums.background,
                  fit: fit)
              .copyWith(
            boxShadow: [
              BoxShadow(),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: context.textTheme.headline4?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(blurRadius: 7),
                    ]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                subtitle,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey.shade300, shadows: [
                  Shadow(blurRadius: 10, color: Colors.black),
                  Shadow(blurRadius: 10, color: Colors.black),
                ]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }
}
