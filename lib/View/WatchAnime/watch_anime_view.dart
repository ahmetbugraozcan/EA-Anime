import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';

import 'package:flutterglobal/Provider/anime/watch_anime_cubit.dart';
import 'package:flutterglobal/Provider/anime/watch_anime_state.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_cubit.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/watch_anime_details_view.dart';

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
              color: Colors.red,
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
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
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
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: CachedNetworkImage(
                                        placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                        imageUrl: state.animeEpisodeList[index]
                                                .thumbnail ??
                                            state.animeEpisodeList[index]
                                                .animeImage ??
                                            ""),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 3.0),
                                    child: Text(state.animeEpisodeList[index]
                                            .episodeDescription ??
                                        ""),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0, left: 12.0),
              child: Text("Son Eklenen Animeler",
                  style: context.textTheme.headlineSmall),
            )
          ],
        ),
      ),
    );
  }
}
