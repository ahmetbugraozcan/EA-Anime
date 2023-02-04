import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/anime.dart';
import 'package:flutterglobal/View/AnimeDetails/cubit/anime_details_cubit.dart';
import 'package:flutterglobal/View/AnimeDetails/cubit/anime_details_state.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_cubit.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/watch_anime_details_view.dart';
import 'package:flutterglobal/Widgets/Cards/AnimeCards/anime_card.dart';
import 'package:flutterglobal/Widgets/Cards/AnimeCards/anime_episode_card.dart';

class AnimeDetails extends StatelessWidget {
  AnimeDetailsCubit cubit;
  AnimeDetails({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anime Detay"),
      ),
      body: Builder(builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      width: context.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: cubit.selectedAnime.thumbnail ?? "",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.selectedAnime.title ?? "-",
                            style: context.textTheme.titleLarge,
                          ),
                          Text(
                            "${cubit.selectedAnime.episodesCount ?? "-"} Bölüm",
                            style: context.textTheme.bodySmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  cubit.selectedAnime.myAnimeListScore == null
                                      ? "-"
                                      : cubit.selectedAnime.myAnimeListScore
                                              .toString() +
                                          "/10",
                                ),
                                Icon(Icons.star, color: Colors.yellow),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                child: Builder(builder: (context) {
                  if (cubit.selectedAnime.genres == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Wrap(
                    children: List.generate(
                      cubit.selectedAnime.genres!.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Chip(
                          backgroundColor: Colors.primaries[index % 16],
                          label: Text(
                            cubit.selectedAnime.genres![index],
                            style: context.textTheme.bodySmall
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  cubit.selectedAnime.description ?? "-",
                  style: context.textTheme.titleSmall,
                ),
              ),

              // related animes
              BlocBuilder<AnimeDetailsCubit, AnimeDetailsState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    previous.isRelatedAnimesLoading !=
                    current.isRelatedAnimesLoading,
                builder: (context, state) {
                  if (state.isRelatedAnimesLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.relatedAnimes.isEmpty) {
                    return Container();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("İlgili Animeler"),
                      Container(
                        height: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.relatedAnimes.length,
                          itemBuilder: (context, index) => AnimeCard(
                            imageUrl: state.relatedAnimes[index].thumbnail,
                            onTap: () {
                              // cubit.setSelectedAnime(state.relatedAnimes[index]);
                            },
                            title: state.relatedAnimes[index].title,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              // episodes
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 12.0),
                child: BlocBuilder<AnimeDetailsCubit, AnimeDetailsState>(
                    bloc: cubit,
                    buildWhen: (previous, current) =>
                        previous.animeEpisodes != current.animeEpisodes,
                    builder: (context, state) {
                      if (state.selectedAnime.studios == null) {
                        return Container();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Bölümler",
                              style: context.textTheme.headlineSmall),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.animeEpisodes.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return AnimeEpisodeCard(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WatchAnimeDetailsView(
                                          cubit: WatchAnimeDetailsCubit(
                                              animeEpisode:
                                                  state.animeEpisodes[index]),
                                        ),
                                      ),
                                    );
                                  },
                                  animeEpisode: state.animeEpisodes[index],
                                );
                              }),
                        ],
                      );
                    }),
              ),
              // studios
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: BlocBuilder<AnimeDetailsCubit, AnimeDetailsState>(
                    bloc: cubit,
                    buildWhen: (previous, current) =>
                        previous.selectedAnime != current.selectedAnime,
                    builder: (context, state) {
                      if (state.selectedAnime.studios == null) {
                        return Container();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Stüdyolar",
                              style: context.textTheme.headlineSmall),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.selectedAnime.studios!.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Icon(Icons.fiber_manual_record),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  title:
                                      Text(state.selectedAnime.studios![index]),
                                );
                              }),
                        ],
                      );
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}
