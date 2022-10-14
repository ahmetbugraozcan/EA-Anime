import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/wallpaper_model.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/Provider/wallpaper/cubit/wallpaper_cubit.dart';
import 'package:flutterglobal/View/WallpaperDetail/wallpaper_detail_view.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';
import 'package:flutterglobal/Widgets/Buttons/back_button.dart';
import 'package:flutterglobal/Widgets/Buttons/wallpaper_set_button.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class WallpaperView extends StatefulWidget {
  WallpaperView({super.key});

  @override
  State<WallpaperView> createState() => _WallpaperViewState();
}

class _WallpaperViewState extends State<WallpaperView> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(_scrollListener);
    context.read<WallpaperCubit>().getWallpaperData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: BlocBuilder<WallpaperCubit, WallpaperState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            bloc: context.read<WallpaperCubit>(),
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Builder(
                        //   builder: (context) {
                        //     if (state.filterWord != "") {
                        //       return Row(
                        //         children: [
                        //           Padding(
                        //             padding: const EdgeInsets.all(12.0),
                        //             child: Text(
                        //               "Filtering : ",
                        //               style: context.textTheme.subtitle2
                        //                   ?.copyWith(color: Colors.white),
                        //             ),
                        //           ),
                        //           InkWell(
                        //             onTap: () {
                        //               context
                        //                   .read<WallpaperCubit>()
                        //                   .setFilterWord("");
                        //               Navigator.pop(context);
                        //             },
                        //             child: Chip(
                        //               backgroundColor: Colors.primaries[0],
                        //               label: Row(
                        //                 children: [
                        //                   Text(
                        //                     "${state.filterWord}",
                        //                     style: context.textTheme.subtitle2
                        //                         ?.copyWith(color: Colors.white),
                        //                   ),
                        //                   Icon(
                        //                     Icons.close_outlined,
                        //                     color: Colors.white,
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           )
                        //         ],
                        //       );
                        //     } else {
                        //       return Container();
                        //     }
                        //   },
                        // ),
                        BackButtonWidget(),
                        BlocBuilder<WallpaperCubit, WallpaperState>(
                          buildWhen: (previous, current) =>
                              previous.wallpaperModels !=
                              current.wallpaperModels,
                          bloc: context.read<WallpaperCubit>(),
                          builder: (context, state) {
                            // if (state.gridState == GridState.ONE) {
                            //   return Expanded(
                            //     child: buildPageViewWallpapers(state),
                            //   );
                            // }
                            // if (state.gridState == GridState.TWO) {
                            //   return Expanded(
                            //     child: buildWallpapersGrid(state),
                            //   );
                            // }

                            // return Expanded(
                            //   child: buildPageViewWallpapers(state),
                            // );
                            return Expanded(
                              child: buildWallpapersGrid(state),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<AdsProviderCubit, AdsProviderState>(
                      bloc: context.read<AdsProviderCubit>(),
                      buildWhen: (previous, current) =>
                          previous.bannerAd != current.bannerAd,
                      builder: (context, state) {
                        print(
                            "ADSPROVIDER BUILDER :${context.watch<AdsProviderCubit>().state.bannerAd}");
                        if (context.read<AdsProviderCubit>().state.bannerAd !=
                                null &&
                            context
                                .read<AdsProviderCubit>()
                                .state
                                .isBannerAdLoaded) {
                          return SizedBox(
                            height: context
                                .watch<AdsProviderCubit>()
                                .state
                                .bannerAd
                                ?.size
                                .height
                                .toDouble(),
                            width: context
                                .watch<AdsProviderCubit>()
                                .state
                                .bannerAd
                                ?.size
                                .width
                                .toDouble(),
                            child: AdWidget(
                              ad: context
                                  .read<AdsProviderCubit>()
                                  .state
                                  .bannerAd!,
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Center(
                                child: CircularProgressIndicator.adaptive()),
                          ),
                        );
                      }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildWallpapersGrid(WallpaperState state) {
    List<WallpaperModel> wallpapers = state.wallpaperModels;

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: GridView.builder(
                // cacheExtent: 1000,
                controller: controller,
                physics: BouncingScrollPhysics(),
                itemCount: state.wallpaperModels.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (context, index) {
                  return BounceWithoutHover(
                    duration: Duration(milliseconds: 100),
                    onPressed: () {
                      context
                          .read<WallpaperCubit>()
                          .selectWallpaper(wallpapers[index]);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WallpaperDetailView(),
                        ),
                      );
                    },
                    child: Hero(
                      tag: "wallpaper${wallpapers[index].imageUrl}",
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Utils.instance
                                  .getPNGImage(ImageEnums.anyaLoading))),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white.withOpacity(0.2),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: wallpapers[index].imageUrl.toString(),
                          memCacheWidth: 450,
                          memCacheHeight: 900,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            BlocBuilder<WallpaperCubit, WallpaperState>(
              bloc: context.read<WallpaperCubit>(),
              buildWhen: (previous, current) =>
                  previous.isPaginationLoading != current.isPaginationLoading,
              builder: (context, state) {
                if (state.isPaginationLoading) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                          child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      )),
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ],
    );
  }

  PageView buildPageViewWallpapers(WallpaperState state) {
    List<WallpaperModel> wallpapers = state.wallpaperModels;

    return PageView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: wallpapers.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              memCacheWidth: 450,
              memCacheHeight: 900,
              imageUrl: wallpapers[index].imageUrl.toString(),
              placeholder: (context, url) => Center(
                  child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.white,
              )),
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    wallpapers[index].animeName.toString(),
                    style: context.textTheme.headline6
                        ?.copyWith(color: Colors.grey.shade200, shadows: [
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
                          wallpapers[index].tags?.length ?? 0, (i) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Chip(
                            backgroundColor:
                                Colors.primaries[i % Colors.primaries.length],
                            label: Text(
                              wallpapers[index].tags?[i].toString() ?? "",
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
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orange.withOpacity(.8),
                        child: Builder(builder: (context) {
                          if (state.downloadingImages
                              .contains(wallpapers[index].id)) {
                            return SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              ),
                            );
                          }
                          return InkWell(
                            onTap: () async {
                              if (await context
                                  .read<WallpaperCubit>()
                                  .willShowAd()) {
                                print("willshow ad");

                                await context
                                    .read<AdsProviderCubit>()
                                    .getWallpaperRewardAd();
                                context
                                    .read<AdsProviderCubit>()
                                    .state
                                    .adForWallpaper
                                    ?.show(
                                  onUserEarnedReward: (ad, reward) {
                                    downloadImageAndShowSnackbar(
                                        context, wallpapers, index);
                                  },
                                );
                              } else {
                                downloadImageAndShowSnackbar(
                                    context, wallpapers, index);
                              }
                            },
                            child: Icon(
                              Icons.download,
                              color: Colors.white,
                            ),
                          );
                        }),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.orange.withOpacity(.8),
                        child: Builder(builder: (context) {
                          if (state.settingWallpapers
                              .contains(wallpapers[index].id)) {
                            return SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              ),
                            );
                          }

                          return WallpaperSetButton(
                            onSelected: (p0) async {
                              bool isSet = await context
                                  .read<WallpaperCubit>()
                                  .setWallpaper(
                                    wallpapers[index].id,
                                    wallpapers[index].imageUrl.toString(),
                                    p0,
                                  );
                              if (isSet) {
                                context.showSnackbar(
                                    title: "Başarılı",
                                    icon: Icon(
                                      Icons.verified,
                                      color: Colors.green,
                                    ),
                                    subtitle: "Duvar kağıdı başarıyla eklendi.",
                                    borderColor: Colors.green);
                              } else {
                                context.showSnackbar(
                                    title: "Hata",
                                    icon: Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                    subtitle: "Duvar kağıdı eklenemedi.",
                                    borderColor: Colors.red);
                              }
                            },
                          );
                        }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> downloadImageAndShowSnackbar(
      BuildContext context, List<WallpaperModel> wallpapers, int index) async {
    try {
      bool isSet = await context.read<WallpaperCubit>().downloadImage(
            wallpapers[index].id,
            wallpapers[index].imageUrl.toString(),
          );
      if (isSet) {
        context.showSnackbar(
            title: "Başarılı",
            icon: Icon(
              Icons.verified,
              color: Colors.green,
            ),
            subtitle: "Duvar kağıdı başarıyla indirildi.",
            borderColor: Colors.green);
      } else {
        context.showSnackbar(
            title: "Hata",
            icon: Icon(
              Icons.error,
              color: Colors.red,
            ),
            subtitle: "Duvar kağıdı indirilirken bir hata oluştu.",
            borderColor: Colors.red);
      }
    } catch (err) {
      context.showSnackbar(
          title: "Hata",
          icon: Icon(
            Icons.error,
            color: Colors.red,
          ),
          subtitle: "Duvar kağıdı indirilirken bir hata oluştu.",
          borderColor: Colors.red);
    }
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 500) {
      print("controller.position ${controller.position.extentAfter}");
      context.read<WallpaperCubit>().onPagination();
      print(context
              .read<WallpaperCubit>()
              .state
              .wallpaperModels
              .length
              .toString() +
          " asdsa");
    }
  }
}
