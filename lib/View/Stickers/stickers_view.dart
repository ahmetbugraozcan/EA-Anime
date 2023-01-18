import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/View/StickerDetails/sticker_details_view.dart';
import 'package:flutterglobal/Widgets/Buttons/back_button.dart';

import 'cubit/stickers_cubit.dart';

class StickersView extends StatefulWidget {
  StickersView({super.key});

  @override
  State<StickersView> createState() => _StickersViewState();
}

class _StickersViewState extends State<StickersView> {
  var cubit = StickersCubit();

  late ScrollController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ScrollController()..addListener(_onScrollEnd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: BlocBuilder<StickersCubit, StickersState>(
            bloc: cubit,
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading ||
                previous.stickerPacks != current.stickerPacks,
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                    child: CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                ));
              } else {
                return Column(
                  children: [
                    BackButtonWidget(),
                    Expanded(
                      child: ListView.builder(
                        controller: controller,
                        itemCount: state.stickerPacks.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => StickerDetailsView(
                                      selectedStickerPack:
                                          state.stickerPacks[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  color: Colors.white.withOpacity(.35),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GridView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: state
                                                .stickerPacks[index].stickerUrls
                                                ?.sublist(0, 4)
                                                .length,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    mainAxisExtent: 50,
                                                    crossAxisCount: 4),
                                            itemBuilder: (context, i) {
                                              if (state.stickerPacks[index]
                                                      .stickerUrls?[i] !=
                                                  null) {
                                                return Container(
                                                  width: 40,
                                                  height: 40,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    /*
                                                            CachedNetworkImage(
                                                              imageUrl: state
                                                                  .stickerPacks![index]
                                                                  .stickerUrls![i],
                                                              fit: BoxFit.cover,
                                                            )
                                                            */
                                                    child: CachedNetworkImage(
                                                      imageUrl: state
                                                          .stickerPacks[index]
                                                          .stickerUrls![i],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return Container();
                                              }
                                            },
                                          ),
                                        ),
                                        Text(
                                          "+${state.stickerPacks[index].stickerUrls?.length == null ? 0 : state.stickerPacks[index].stickerUrls!.length - 4}",
                                          style: context.textTheme.headline6,
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                          state.stickerPacks[index].name
                                                  ?.toString() ??
                                              "",
                                          style:
                                              context.textTheme.headlineSmall),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    BlocBuilder<StickersCubit, StickersState>(
                      bloc: cubit,
                      buildWhen: (previous, current) =>
                          previous.isPaginationLoading !=
                          current.isPaginationLoading,
                      builder: (context, state) {
                        if (state.isPaginationLoading) {
                          return Center(
                              child: CircularProgressIndicator.adaptive(
                            backgroundColor: Colors.white,
                          ));
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  _onScrollEnd() {
    if (controller.position.atEdge && controller.position.pixels != 0) {
      if (!cubit.state.isLoading && !cubit.state.isPaginationLoading) {
        cubit.getStickerPacks();
      }
    }
  }
}
