import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/anime_episode.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_cubit.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_state.dart';
import 'package:video_player/video_player.dart';

class WatchAnimeDetailsView extends StatelessWidget {
  // AnimeEpisode animeEpisode;
  WatchAnimeDetailsCubit cubit;
  WatchAnimeDetailsView({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: BlocBuilder<WatchAnimeDetailsCubit, WatchAnimeDetailsState>(
          bloc: cubit,
          builder: (context, state) {
            return Text(
                "${state.animeEpisode.title} - ${state.animeEpisode.episodeNumber}");
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: BlocBuilder<WatchAnimeDetailsCubit, WatchAnimeDetailsState>(
        bloc: cubit,
        builder: (context, state) {
          return Container(
            width: context.width,
            height: context.height,
            decoration:
                Utils.instance.backgroundDecoration(ImageEnums.background),
            child: Center(
              child: cubit.controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: cubit.controller.value.aspectRatio,
                      child: VideoPlayer(cubit.controller),
                    )
                  : Center(
                      child: Text("video oynatılamadı"),
                    ),
            ),
          );
        },
      ),
    );
  }
}
