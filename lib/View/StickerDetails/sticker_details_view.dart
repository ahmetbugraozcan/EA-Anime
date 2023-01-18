import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Exceptions/simple_exception.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Init/Language/locale_keys.g.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/sticker_pack_model.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/Provider/wallpaper/cubit/wallpaper_cubit.dart';
import 'package:flutterglobal/Service/Stickers/stickers_service.dart';
import 'package:flutterglobal/View/StickerDetails/cubit/sticker_details_cubit.dart';
import 'package:flutterglobal/Widgets/Buttons/back_button.dart';
import 'package:whatsapp_stickers_plus/exceptions.dart';

class StickerDetailsView extends StatelessWidget {
  StickerPackModel selectedStickerPack;
  StickerDetailsView({super.key, required this.selectedStickerPack});
  var cubit = StickerDetailsCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
      child: SafeArea(
        child: SizedBox.expand(
          child: Column(
            children: [
              Row(
                children: [
                  BackButtonWidget(),
                  Expanded(
                    child: Text(
                      selectedStickerPack.name ?? "",
                      style: context.textTheme.headline5
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: selectedStickerPack.stickerUrls?[index] ?? "",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    );
                  },
                  itemCount: selectedStickerPack.stickerUrls?.length ?? 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<StickerDetailsCubit, StickerDetailsState>(
                    bloc: cubit,
                    builder: (context, state) {
                      return ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //   backgroundColor: Color(0xff25D366),
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        // ),
                        child: state.isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(LocaleKeys.stickersPage_addToWhattsap.tr()),
                        onPressed: () async {
                          try {
                            await cubit.installStickerPack(selectedStickerPack);
                          } on SimpleException catch (e) {
                            print("SimpleException: ${e.message}");
                            context.showSnackbar(
                                title: LocaleKeys.general_error.tr(),
                                icon: Icon(Icons.error),
                                subtitle: "Something went wrong",
                                borderColor: Colors.red);
                          } finally {
                            context
                                .read<AdsProviderCubit>()
                                .getStickerRewardAd();
                            cubit.changeLoadingState(false);
                          }
                          // context
                          //     .read<AdsProviderCubit>()
                          //     .state
                          //     .adForStickers
                          //     ?.show(
                          //   onUserEarnedReward: (ad, reward) async {
                          //     try {
                          //       await cubit
                          //           .installStickerPack(selectedStickerPack);
                          //     } on WhatsappStickersException catch (e) {
                          //       context.showSnackbar(
                          //           title: "Hata",
                          //           icon: Icon(Icons.error),
                          //           subtitle: "Bir hata oluştu.",
                          //           borderColor: Colors.red);
                          //     } catch (e) {
                          //       context.showSnackbar(
                          //           title: "Hata",
                          //           icon: Icon(Icons.error),
                          //           subtitle: "Bir hata oluştu.",
                          //           borderColor: Colors.red);
                          //     } finally {
                          //       context
                          //           .read<AdsProviderCubit>()
                          //           .getStickerRewardAd();
                          //     }
                          //   },
                          // );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
