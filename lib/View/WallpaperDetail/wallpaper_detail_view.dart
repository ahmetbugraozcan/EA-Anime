import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/wallpaper_model.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/Provider/wallpaper/cubit/wallpaper_cubit.dart';
import 'package:flutterglobal/Service/wallpaper_manager_service.dart';
import 'package:flutterglobal/Widgets/Buttons/wallpaper_set_button.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class WallpaperDetailView extends StatefulWidget {
  WallpaperDetailView({super.key});

  @override
  State<WallpaperDetailView> createState() => _WallpaperDetailViewState();
}

class _WallpaperDetailViewState extends State<WallpaperDetailView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<AdsProviderCubit>(context).getBannerAd();
  }

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
                          imageUrl: context
                              .read<WallpaperCubit>()
                              .state
                              .selectedWallpaper!
                              .imageUrl!,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }
                                  return InkWell(
                                    onTap: () async {
                                      bool isSet = await context
                                          .read<WallpaperCubit>()
                                          .downloadImage(
                                            state.selectedWallpaper?.id,
                                            state.selectedWallpaper?.imageUrl,
                                          );
                                      if (isSet) {
                                        context.showSnackbar(
                                            title: "Başarılı",
                                            icon: Icon(
                                              Icons.verified,
                                              color: Colors.green,
                                            ),
                                            subtitle:
                                                "Duvar kağıdı başarıyla indirildi.",
                                            borderColor: Colors.green);
                                      } else {
                                        context.showSnackbar(
                                            title: "Hata",
                                            icon: Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                            subtitle:
                                                "Duvar kağıdı indirilirken bir hata oluştu.",
                                            borderColor: Colors.red);
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
                              child:
                                  BlocBuilder<WallpaperCubit, WallpaperState>(
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
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          );
                                        }
                                        return WallpaperSetButton(
                                          onSelected: (p0) async {
                                            bool isSet = await context
                                                .read<WallpaperCubit>()
                                                .setWallpaper(
                                                  state.selectedWallpaper?.id,
                                                  state.selectedWallpaper
                                                      ?.imageUrl
                                                      .toString(),
                                                  p0,
                                                );
                                            if (isSet) {
                                              context.showSnackbar(
                                                  title: "Başarılı",
                                                  icon: Icon(
                                                    Icons.verified,
                                                    color: Colors.green,
                                                  ),
                                                  subtitle:
                                                      "Duvar kağıdı başarıyla eklendi.",
                                                  borderColor: Colors.green);
                                            } else {
                                              context.showSnackbar(
                                                  title: "Hata",
                                                  icon: Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                  subtitle:
                                                      "Duvar kağıdı eklenirken bir hata oluştu.",
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
                                    child: InkWell(
                                      onTap: () {
                                        context
                                            .read<WallpaperCubit>()
                                            .filterWallpapersWithAnimeName(
                                              context
                                                      .read<WallpaperCubit>()
                                                      .state
                                                      .selectedWallpaper
                                                      ?.tags?[i]
                                                      .toString() ??
                                                  "",
                                            );
                                        Navigator.pop(context);
                                      },
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
                // Builder(builder: (context) {
                //   if (context.watch<AdsProviderCubit>().state.bannerAd !=
                //       null) {
                //     return SizedBox(
                //       height: context
                //           .watch<AdsProviderCubit>()
                //           .state
                //           .bannerAd
                //           ?.size
                //           .height
                //           .toDouble(),
                //       width: context
                //           .watch<AdsProviderCubit>()
                //           .state
                //           .bannerAd
                //           ?.size
                //           .width
                //           .toDouble(),
                //       child: AdWidget(
                //         ad: context.read<AdsProviderCubit>().state.bannerAd!,
                //       ),
                //     );
                //   }
                //   return SizedBox();
                // })
              ],
            ),
          )),
    );
  }
}
