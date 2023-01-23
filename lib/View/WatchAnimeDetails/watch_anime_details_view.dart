import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutterglobal/Core/Extensions/context_extensions.dart';

import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_cubit.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_state.dart';
import 'package:video_player/video_player.dart';

class WatchAnimeDetailsView extends StatefulWidget {
  WatchAnimeDetailsCubit cubit;
  WatchAnimeDetailsView({super.key, required this.cubit});

  @override
  State<WatchAnimeDetailsView> createState() => _WatchAnimeDetailsViewState();
}

class _WatchAnimeDetailsViewState extends State<WatchAnimeDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: BlocBuilder<WatchAnimeDetailsCubit, WatchAnimeDetailsState>(
          bloc: widget.cubit,
          builder: (context, state) {
            return Text(
                "${state.animeEpisode.title} - ${state.animeEpisode.episodeNumber}. Bölüm");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WatchAnimeDetailsCubit, WatchAnimeDetailsState>(
          bloc: widget.cubit,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state.controller != null &&
                        state.controller!.value.isInitialized
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AspectRatio(
                          aspectRatio: state.controller!.value.aspectRatio,
                          child: VideoPlayer(state.controller!),
                        ),
                      )
                    : Container(
                        height: context.height / 3,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text("Bölüm Açıklaması",
                      style: context.textTheme.headlineSmall),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    state.animeEpisode.description ?? " Açıklama mevcut değil.",
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
