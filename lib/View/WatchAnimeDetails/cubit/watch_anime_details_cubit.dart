import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Models/anime_episode.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_state.dart';
import 'package:video_player/video_player.dart';

class WatchAnimeDetailsCubit extends Cubit<WatchAnimeDetailsState> {
  AnimeEpisode animeEpisode;
  late VideoPlayerController controller;

  WatchAnimeDetailsCubit({required this.animeEpisode})
      : super(WatchAnimeDetailsState(animeEpisode: animeEpisode)) {
    controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4" ??
            "");

    controller.initialize().then((value) {
      controller.play();
      print("play started");
      emit(state.copyWith(isVideoLoading: false));
    });
  }
}
