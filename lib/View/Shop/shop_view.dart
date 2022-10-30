import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Constants/app_constants.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Init/Language/locale_keys.g.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/Provider/cubit/user_provider_cubit.dart';
import 'package:flutterglobal/View/Shop/cubit/shop_cubit.dart';
import 'package:flutterglobal/Widgets/Cards/shop_card.dart';
import 'package:flutterglobal/Widgets/Game/user_assets_info.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ShopView extends StatelessWidget {
  ShopView({super.key});

  ShopCubit cubit = ShopCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: Column(
            children: [
              Spacer(),
              IgnorePointer(ignoring: true, child: UserAssetsInfo()),
              Spacer(),
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // todo save game state
                            },
                            icon: Icon(Icons.arrow_back),
                          ),
                        ),
                        // CircleAvatar(
                        //   child: IconButton(
                        //     onPressed: () {},
                        //     icon: Icon(Icons.settings),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 18,
                child: Container(
                  margin: EdgeInsets.all(12),
                  width: double.infinity,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      ShopCard(
                          title:
                              "${AppConstants.instance.goldCountForAnswer} ${LocaleKeys.general_gold.tr()}",
                          isloading: context
                              .watch<AdsProviderCubit>()
                              .state
                              .isAdLoading,
                          subtitle: LocaleKeys.shop_earnGoldSubtitle.tr(args: [
                            AppConstants.instance.goldCountForAnswer.toString()
                          ]),
                          image: ImageEnums.coin,
                          onTap: () {
                            context.read<AdsProviderCubit>().state.ad?.show(
                                onUserEarnedReward:
                                    (AdWithoutView ad, RewardItem rewardItem) {
                              context.read<UserProviderCubit>().addGold(
                                  AppConstants.instance.goldCountForAnswer);
                              context
                                  .read<AdsProviderCubit>()
                                  .getInitialRewardAd();
                            });
                          }),
                      ShopCard(
                        title: "1 ${LocaleKeys.general_key.tr()}",
                        subtitle: LocaleKeys.shop_buyKeySubtitle
                            .tr(args: ["${AppConstants.instance.keyPrice}"]),
                        image: ImageEnums.goldkey,
                        onTap: () {
                          if ((context
                                      .read<UserProviderCubit>()
                                      .state
                                      .user
                                      ?.goldCount ??
                                  0) >=
                              AppConstants.instance.keyPrice) {
                            context.read<UserProviderCubit>().buyKey();
                          } else {
                            context.showSnackbar(
                              title: LocaleKeys.shop_notEnoughGold.tr(),
                              icon: Icon(Icons.error),
                              borderColor: Colors.red,
                              subtitle: LocaleKeys.shop_canEarnGold.tr(),
                            );
                          }
                        },
                        shopCardType: ShopCardType.PURCHASE,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
