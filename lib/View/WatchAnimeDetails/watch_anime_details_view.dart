import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:flutterglobal/Core/Extensions/context_extensions.dart';

import 'package:flutterglobal/View/AnimeDetails/anime_details.dart';
import 'package:flutterglobal/View/AnimeDetails/cubit/anime_details_cubit.dart';

import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_cubit.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_state.dart';
import 'package:flutterglobal/Widgets/Cards/AnimeCards/anime_episode_card.dart';

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
                  "${state.animeEpisode.animeName} - ${state.animeEpisode.episodeNumber}. Bölüm");
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child:
                  BlocBuilder<WatchAnimeDetailsCubit, WatchAnimeDetailsState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    previous.isVideoLoading != current.isVideoLoading ||
                    previous.selectedOption != current.selectedOption ||
                    previous.animeEpisode != current.animeEpisode ||
                    previous.parentAnime != current.parentAnime,
                builder: (context, state) => Stack(
                  children: [
                    state.isVideoLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : InAppWebView(
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
                                return await NavigationActionPolicy.ALLOW;
                              }
                              return await NavigationActionPolicy.CANCEL;
                            },
                            initialUrlRequest: URLRequest(
                                url: Uri.parse(state.selectedOption!.url!)),
                            initialOptions: InAppWebViewGroupOptions(
                                crossPlatform: InAppWebViewOptions(
                                  mediaPlaybackRequiresUserGesture: false,
                                  useShouldOverrideUrlLoading: true,
                                ),
                                android: AndroidInAppWebViewOptions(
                                  useHybridComposition: true,
                                ),
                                ios: IOSInAppWebViewOptions(
                                  allowsInlineMediaPlayback: true,
                                )),
                          ),
                  ],
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
                            child: BlocBuilder<WatchAnimeDetailsCubit,
                                WatchAnimeDetailsState>(
                              bloc: cubit,
                              buildWhen: (previous, current) =>
                                  previous.animeEpisode !=
                                      current.animeEpisode ||
                                  previous.parentAnime != current.parentAnime,
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        if (state.animeEpisode.episodeNumber !=
                                                null &&
                                            state.animeEpisode.episodeNumber! >
                                                1) {
                                          return Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white),
                                                onPressed: () {
                                                  cubit.getPreviousEpisode();
                                                },
                                                child: Text("Önceki Bölüm"),
                                              ),
                                            ),
                                          );
                                        }

                                        return Spacer();
                                      },
                                    ),
                                    Builder(builder: (context) {
                                      if (state.animeEpisode.episodeNumber !=
                                              null &&
                                          state.animeEpisode.episodeNumber! <
                                              (state.parentAnime
                                                      ?.episodesCount ??
                                                  0)) {
                                        return Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.white),
                                              onPressed: () {
                                                cubit.getNextEpisode();
                                              },
                                              child: Text("Sonraki Bölüm"),
                                            ),
                                          ),
                                        );
                                      }
                                      return Spacer();
                                    }),
                                  ],
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Text("Bölüm Açıklaması",
                                style: context.textTheme.headlineSmall),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              state.animeEpisode.description ??
                                  "Bölüm açıklaması bulunamadı.",
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12),
                            width: context.width,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AnimeDetails(
                                        cubit: AnimeDetailsCubit(
                                          animeID: state.animeEpisode.animeId,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Text("Animeye git")),
                          ),
                          BlocBuilder<WatchAnimeDetailsCubit,
                              WatchAnimeDetailsState>(
                            buildWhen: (previous, current) =>
                                previous.animeEpisodes !=
                                    current.animeEpisodes ||
                                previous.animeEpisode != current.animeEpisode,
                            bloc: cubit,
                            builder: (context, state) {
                              if (state.animeEpisodes.isEmpty) {
                                return SizedBox.shrink();
                              }
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0, vertical: 16.0),
                                      child: Text("Tüm Bölümler",
                                          style:
                                              context.textTheme.headlineSmall),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: state.animeEpisodes.length,
                                      itemBuilder: (context, index) {
                                        return AnimeEpisodeCard(
                                          isHighlighted: state
                                                  .animeEpisodes[index]
                                                  ?.episodeNumber ==
                                              state.animeEpisode.episodeNumber,
                                          animeEpisode:
                                              state.animeEpisodes[index],
                                          onTap: () {
                                            cubit.setSelectedEpisode(
                                                state.animeEpisodes[index]);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
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
