import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:flutterglobal/Core/Extensions/context_extensions.dart';

import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_cubit.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_state.dart';

class WatchAnimeDetailsView extends StatelessWidget {
  WatchAnimeDetailsCubit cubit;
  WatchAnimeDetailsView({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: BlocBuilder<WatchAnimeDetailsCubit, WatchAnimeDetailsState>(
            bloc: cubit,
            builder: (context, state) {
              return Text(
                  "${state.animeEpisode.title} - ${state.animeEpisode.episodeNumber}. Bölüm");
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child:
                    BlocBuilder<WatchAnimeDetailsCubit, WatchAnimeDetailsState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      previous.isVideoLoading != current.isVideoLoading ||
                      previous.selectedOption != current.selectedOption,
                  builder: (context, state) => Stack(
                    children: [
                      state.isVideoLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(),
                      Container(
                        child: InAppWebView(
                          onWebViewCreated: (controller) {
                            cubit.webViewController = controller;
                          },
                          shouldOverrideUrlLoading:
                              (controller, navigationAction) async {
                            bool canNavigate = false;
                            state.animeEpisode.links!.forEach((element) {
                              if (navigationAction.request.url.toString() ==
                                  element.url) {
                                canNavigate = true;
                              }
                            });
                            if (canNavigate) {
                              return NavigationActionPolicy.ALLOW;
                            }
                            return NavigationActionPolicy.CANCEL;
                          },
                          initialUrlRequest: URLRequest(
                              url: Uri.parse(state.selectedOption!.url!)),
                          initialOptions: InAppWebViewGroupOptions(
                              crossPlatform: InAppWebViewOptions(
                                mediaPlaybackRequiresUserGesture: false,
                                useShouldOverrideUrlLoading: true,
                              ),
                              android: AndroidInAppWebViewOptions(
                                  // useHybridComposition: true,
                                  ),
                              ios: IOSInAppWebViewOptions(
                                allowsInlineMediaPlayback: true,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SafeArea(
                child: SingleChildScrollView(
                  child: BlocBuilder<WatchAnimeDetailsCubit,
                      WatchAnimeDetailsState>(
                    bloc: cubit,
                    buildWhen: (previous, current) =>
                        previous.animeEpisode != current.animeEpisode,
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          state.animeEpisode.links != null
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  child: Wrap(
                                    spacing: 12,
                                    children: List.generate(
                                      state.animeEpisode.links!.length,
                                      (index) => RawChip(
                                        backgroundColor:
                                            Colors.primaries[index % 16],
                                        onPressed: () {
                                          cubit.setSelectedOption(
                                              state.animeEpisode.links![index]);
                                        },
                                        label: Text(
                                          state.animeEpisode.links![index]
                                                  .option ??
                                              "-",
                                          style: context.textTheme.titleMedium!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blueAccent.shade100,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: Text("Önceki Bölüm"),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white),
                                  onPressed: () {},
                                  child: Text("Sonraki Bölüm"),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text("Bölüm Açıklaması",
                                style: context.textTheme.headlineSmall),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text(
                              state.animeEpisode.description ??
                                  " Açıklama mevcut değil.",
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.0),
                            width: context.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () {},
                                child: Text("Animeye git")),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
