import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';

import 'package:flutterglobal/Provider/anime/watch_anime_cubit.dart';
import 'package:flutterglobal/Provider/anime/watch_anime_state.dart';
import 'package:flutterglobal/View/AnimeDetails/anime_details.dart';
import 'package:flutterglobal/View/AnimeDetails/cubit/anime_details_cubit.dart';
import 'package:flutterglobal/View/AnimeDetails/cubit/anime_details_state.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_cubit.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/watch_anime_details_view.dart';
import 'package:flutterglobal/Widgets/Cards/AnimeCards/anime_card.dart';

class WatchAnimeView extends StatelessWidget {
  WatchAnimeView({super.key});

  var bloc = WatchAnimeCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anime izle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12.0, left: 12.0),
              child: Text("Son Eklenen Bölümler",
                  style: context.textTheme.headlineSmall),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              height: context.height / 3,
              child: BlocBuilder<WatchAnimeCubit, WatchAnimeState>(
                buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading ||
                    previous.animeEpisodeList != current.animeEpisodeList,
                bloc: context.read<WatchAnimeCubit>(),
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.animeEpisodeList.isEmpty) {
                    return Center(child: Text("Anime listesi boş"));
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.animeEpisodeList.length,
                      itemBuilder: (context, index) {
                        return AnimeCard(
                          title:
                              state.animeEpisodeList[index].episodeDescription,
                          imageUrl: state.animeEpisodeList[index].thumbnail ??
                              state.animeEpisodeList[index].animeImage,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WatchAnimeDetailsView(
                                  cubit: WatchAnimeDetailsCubit(
                                      animeEpisode:
                                          state.animeEpisodeList[index]),
                                ),
                              ),
                            );
                          },
                        );
                      });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0, left: 12.0),
              child: Text("Son Eklenen Animeler",
                  style: context.textTheme.headlineSmall),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              height: context.height / 3,
              child: BlocBuilder<WatchAnimeCubit, WatchAnimeState>(
                buildWhen: (previous, current) =>
                    previous.isAnimeListLoading != current.isAnimeListLoading ||
                    previous.animeList != current.animeList,
                bloc: context.read<WatchAnimeCubit>(),
                builder: (context, state) {
                  if (state.isAnimeListLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.animeList.isEmpty) {
                    return Center(child: Text("Anime listesi boş"));
                  }
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.animeList.length,
                      itemBuilder: (context, index) {
                        return AnimeCard(
                          title: state.animeList[index].title,
                          imageUrl: state.animeList[index].thumbnail,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnimeDetails(
                                  cubit: AnimeDetailsCubit(
                                    selectedAnime: state.animeList[index],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
