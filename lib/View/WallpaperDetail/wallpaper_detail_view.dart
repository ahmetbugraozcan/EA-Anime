import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Init/Language/locale_keys.g.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/wallpaper_model.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/Provider/wallpaper/cubit/wallpaper_cubit.dart';
import 'package:flutterglobal/Widgets/Buttons/wallpaper_set_button.dart';

class WallpaperDetailView extends StatelessWidget {
  WallpaperDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration:
              Utils.instance.backgroundDecoration(ImageEnums.background),
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag:
                            "wallpaper${context.read<WallpaperCubit>().state.selectedWallpaper?.imageUrl}",
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Image.asset(
                            Utils.instance.getPNGImage(ImageEnums.anyaLoading),
                          ),
                          imageUrl: context
                              .read<WallpaperCubit>()
                              .state
                              .selectedWallpaper!
                              .imageUrl!,
                          memCacheHeight: 800,
                          memCacheWidth: 500,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.orange.withOpacity(.8),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.orange.withOpacity(.8),
                              child:
                                  BlocBuilder<WallpaperCubit, WallpaperState>(
                                buildWhen: (previous, current) =>
                                    previous.downloadingImages !=
                                    current.downloadingImages,
                                bloc: context.read<WallpaperCubit>(),
                                builder: (context, state) {
                                  if (state.downloadingImages
                                      .contains(state.selectedWallpaper?.id)) {
                                    return CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  0), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      ),
                                    );
                                  }
                                  return InkWell(
                                    onTap: () async {
                                      if (await context
                                          .read<WallpaperCubit>()
                                          .willShowAd()) {
                                        context
                                            .read<AdsProviderCubit>()
                                            .state
                                            .adForWallpaper
                                            ?.show(
                                          onUserEarnedReward: (ad, reward) {
                                            downloadImageAndShowSnackbar(
                                                context,
                                                state.selectedWallpaper!);
                                            context
                                                .read<AdsProviderCubit>()
                                                .getWallpaperRewardAd();
                                          },
                                        );
                                      } else {
                                        downloadImageAndShowSnackbar(
                                            context, state.selectedWallpaper!);
                                      }
                                    },
                                    child: Icon(
                                      Icons.download,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.orange.withOpacity(.8),
                              child: BlocBuilder<WallpaperCubit,
                                      WallpaperState>(
                                  bloc: context.read<WallpaperCubit>(),
                                  buildWhen: (previous, current) =>
                                      previous.settingWallpapers !=
                                      current.settingWallpapers,
                                  builder: (context, state) {
                                    if (state.settingWallpapers.contains(
                                        state.selectedWallpaper?.id)) {
                                      return SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      );
                                    }
                                    return WallpaperSetButton(
                                      onSelected: (p0) async {
                                        bool isSet = await context
                                            .read<WallpaperCubit>()
                                            .setWallpaper(
                                              state.selectedWallpaper?.id,
                                              state.selectedWallpaper?.imageUrl
                                                  .toString(),
                                              p0,
                                            );
                                        if (isSet) {
                                          context.showSnackbar(
                                              title: LocaleKeys.general_success
                                                  .tr(),
                                              icon: Icon(
                                                Icons.verified,
                                                color: Colors.green,
                                              ),
                                              subtitle: LocaleKeys
                                                  .wallpapers_successfullySetted
                                                  .tr(),
                                              borderColor: Colors.green);
                                        } else {
                                          context.showSnackbar(
                                              title:
                                                  LocaleKeys.general_error.tr(),
                                              icon: Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                              subtitle: LocaleKeys
                                                  .wallpapers_exceptionWhenSetting
                                                  .tr(),
                                              borderColor: Colors.red);
                                        }
                                      },
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context
                                      .read<WallpaperCubit>()
                                      .state
                                      .selectedWallpaper
                                      ?.animeName
                                      .toString() ??
                                  "",
                              style: context.textTheme.headline6?.copyWith(
                                  color: Colors.grey.shade200,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 2,
                                      offset: Offset(0, 2),
                                    ),
                                  ]),
                            ),
                            Container(
                              width: context.width,
                              child: Wrap(
                                children: List.generate(
                                    context
                                            .read<WallpaperCubit>()
                                            .state
                                            .selectedWallpaper
                                            ?.tags
                                            ?.length ??
                                        0, (i) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Chip(
                                      backgroundColor: Colors.primaries[
                                          i % Colors.primaries.length],
                                      label: Text(
                                        context
                                                .read<WallpaperCubit>()
                                                .state
                                                .selectedWallpaper
                                                ?.tags?[i]
                                                .toString() ??
                                            "",
                                        style: context.textTheme.subtitle2
                                            ?.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> downloadImageAndShowSnackbar(
      BuildContext context, WallpaperModel wallpaper) async {
    try {
      bool isSet = await context.read<WallpaperCubit>().downloadImage(
            wallpaper.id,
            wallpaper.imageUrl.toString(),
          );
      if (isSet) {
        context.showSnackbar(
            title: LocaleKeys.general_success.tr(),
            icon: Icon(
              Icons.verified,
              color: Colors.green,
            ),
            subtitle: LocaleKeys.wallpapers_successfullyDownloaded.tr(),
            borderColor: Colors.green);
      } else {
        context.showSnackbar(
            title: LocaleKeys.general_error.tr(),
            icon: Icon(
              Icons.error,
              color: Colors.red,
            ),
            subtitle: LocaleKeys.wallpapers_exceptionWhenDownloading.tr(),
            borderColor: Colors.red);
      }
    } catch (err) {
      context.showSnackbar(
          title: LocaleKeys.general_error.tr(),
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ),
          subtitle: LocaleKeys.wallpapers_exceptionWhenDownloading.tr(),
          borderColor: Colors.red);
    }
  }
}
