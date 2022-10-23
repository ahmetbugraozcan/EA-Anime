import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/cubit/app_provider_cubit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutterglobal/View/Shop/shop_view.dart';

class UserAssetsInfo extends StatelessWidget {
  Widget? centerWidget;
  UserAssetsInfo({super.key, this.centerWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopView(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        Utils.instance.getPNGImage(
                          ImageEnums.goldkey,
                        ),
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${context.watch<AppProviderCubit>().state.user?.keyCount}",
                          style: context.textTheme.subtitle2
                              ?.copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            ...[
              centerWidget ??
                  Icon(
                    Icons.gamepad,
                    color: Colors.white,
                    size: 48,
                  )
            ],
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopView(),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    Utils.instance.getPNGImage(
                      ImageEnums.coin,
                    ),
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${context.watch<AppProviderCubit>().state.user?.goldCount}",
                      style: context.textTheme.subtitle2
                          ?.copyWith(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
