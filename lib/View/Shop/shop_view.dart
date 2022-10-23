import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Constants/app_constants.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/Provider/cubit/app_provider_cubit.dart';
import 'package:flutterglobal/View/Shop/cubit/shop_cubit.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';
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
                              "${AppConstants.instance.goldCountForAnswer} Altın",
                          isloading: context
                              .watch<AdsProviderCubit>()
                              .state
                              .isAdLoading,
                          subtitle:
                              "Kısa bir reklam videosu izleyerek ${AppConstants.instance.goldCountForAnswer} altın kazan.",
                          image: ImageEnums.coin,
                          onTap: () {
                            print(context.read<AdsProviderCubit>().state.ad ??
                                "ad null");
                            context.read<AdsProviderCubit>().state.ad?.show(
                                onUserEarnedReward:
                                    (AdWithoutView ad, RewardItem rewardItem) {
                              context.read<AppProviderCubit>().addGold(
                                  AppConstants.instance.goldCountForAnswer);
                              context
                                  .read<AdsProviderCubit>()
                                  .getInitialRewardAd();
                            });
                          }),
                      ShopCard(
                        title: "1 Anahtar",
                        subtitle: "250 altın harcayarak bir anahtar satın al.",
                        image: ImageEnums.goldkey,
                        onTap: () {
                          if ((context
                                      .read<AppProviderCubit>()
                                      .state
                                      .user
                                      ?.goldCount ??
                                  0) >=
                              250) {
                            context.read<AppProviderCubit>().buyKey();
                          } else {
                            context.showSnackbar(
                              title: "Yeterli altınınız bulunmamaktadır.",
                              icon: Icon(Icons.error),
                              borderColor: Colors.red,
                              subtitle:
                                  "Reklam izleyerek altın kazanabilirsiniz.",
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
