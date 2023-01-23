import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Models/anime_episode.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_state.dart';
import 'package:video_player/video_player.dart';

class WatchAnimeDetailsCubit extends Cubit<WatchAnimeDetailsState> {
  AnimeEpisode animeEpisode;

  WatchAnimeDetailsCubit({required this.animeEpisode})
      : super(WatchAnimeDetailsState(
            animeEpisode: animeEpisode,
            selectedOption: animeEpisode.links?.first)) {
    var controller =
        VideoPlayerController.network(animeEpisode.links?.first.url ?? "");
    emit(state.copyWith(controller: controller));
    state.controller?.initialize().then((_) {
      setIsVideoLoading(false);
    });

    // ..initialize().then((_) {
    //   controller.play();
    //   setIsVideoLoading(false);
    //   // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    // });
  }

  void setController(VideoPlayerController value) {
    emit(state.copyWith(controller: value));
  }

  void setIsVideoLoading(bool value) {
    emit(state.copyWith(isVideoLoading: value));
  }
}
