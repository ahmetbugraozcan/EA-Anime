import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Init/Language/locale_keys.g.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/cubit/user_provider_cubit.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';
import 'package:flutterglobal/Widgets/Buttons/3dbutton.dart';

enum ShopCardType { PURCHASE, VIDEO }

class ShopCard extends StatelessWidget {
  ShopCardType shopCardType;
  VoidCallback? onTap;

  String title;
  String subtitle;
  ImageEnums image;
  bool isloading;

  ShopCard(
      {super.key,
      this.onTap,
      required this.title,
      required this.subtitle,
      required this.image,
      this.isloading = false,
      this.shopCardType = ShopCardType.VIDEO});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      color: Colors.black.withOpacity(.6),
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        leading: Image.asset(
          Utils.instance.getPNGImage(image),
          width: 48,
          height: 48,
        ),
        textColor: Colors.grey.shade200,
        title: Text(
          title,
          style: context.textTheme.headline6?.copyWith(
              fontWeight: FontWeight.bold, color: Colors.grey.shade200),
        ),
        subtitle: Text(
          subtitle,
          style: context.textTheme.caption?.copyWith(
              color: Colors.grey.shade200, fontStyle: FontStyle.italic),
        ),
        trailing: Builder(
          builder: (context) {
            if (isloading)
              return SizedBox(
                width: 100,
                child: ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: context.theme.primaryColor),
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    )),
              );
            switch (shopCardType) {
              case ShopCardType.VIDEO:
                return SizedBox(
                  width: 110,
                  child: ElevatedButton(
                      child: Text(
                        LocaleKeys.general_watch.tr(),
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: onTap ?? () {}),
                );
              case ShopCardType.PURCHASE:
                // return SizedBox(width: 110, height: 40, child: ThreeDButton());
                return SizedBox(
                  width: 110,
                  child: ElevatedButton(
                      child: Text(
                        LocaleKeys.general_buy.tr(),
                        style: context.textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: onTap ?? () {}),
                );
            }
          },
        ),
      ),
    );
  }
}
