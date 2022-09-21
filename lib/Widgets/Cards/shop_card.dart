import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/cubit/app_provider_cubit.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';

enum ShopCardType { PURCHASE, VIDEO }

class ShopCard extends StatelessWidget {
  ShopCardType shopCardType;
  VoidCallback? onTap;

  String title;
  String subtitle;
  ImageEnums image;

  ShopCard(
      {super.key,
      this.onTap,
      required this.title,
      required this.subtitle,
      required this.image,
      this.shopCardType = ShopCardType.VIDEO});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      color: Colors.black,
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
            switch (shopCardType) {
              case ShopCardType.VIDEO:
                return SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      child: Text("İzle"), onPressed: onTap ?? () {}),
                );
              case ShopCardType.PURCHASE:
                return SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      child: Text(
                        "Satın Al",
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
