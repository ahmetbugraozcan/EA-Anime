import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Models/anime_episode.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_state.dart';
import 'package:video_player/video_player.dart';

class WatchAnimeDetailsCubit extends Cubit<WatchAnimeDetailsState> {
  AnimeEpisode animeEpisode;

  WatchAnimeDetailsCubit({required this.animeEpisode})
      : super(WatchAnimeDetailsState(
            animeEpisode: animeEpisode,
            selectedOption: animeEpisode.links?.first));

  void setIsWebViewLoading(bool value) {
    emit(state.copyWith(isWebViewLoading: value));
  }
}
