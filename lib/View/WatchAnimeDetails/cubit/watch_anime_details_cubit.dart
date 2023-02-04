import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterglobal/Models/anime_episode.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/firebase_firestore_service.dart';
import 'package:flutterglobal/View/WatchAnimeDetails/cubit/watch_anime_details_state.dart';

class WatchAnimeDetailsCubit extends Cubit<WatchAnimeDetailsState> {
  AnimeEpisode animeEpisode;
  InAppWebViewController? webViewController;
  WatchAnimeDetailsCubit({required this.animeEpisode})
      : super(WatchAnimeDetailsState(
            animeEpisode: animeEpisode,
            selectedOption: animeEpisode.links?.first)) {
    getAnimeEpisodes();
    setSelectedOption(animeEpisode.links?.first);
  }

  Future<void> getAnimeEpisodes() async {
    List<AnimeEpisode?> animeEpisodes = await FirebaseFireStoreService.instance
        .getAnimeEpisodesForAnime(animeEpisode.animeId!);

    emit(state.copyWith(animeEpisodes: animeEpisodes));
  }

  void getPreviousEpisode() async {
    int index = state.animeEpisodes.indexWhere((element) =>
        element?.episodeNumber == state.animeEpisode.episodeNumber);

    if (index == 0) return;
    AnimeEpisode? animeEpisode = state.animeEpisodes[index - 1];
    if (animeEpisode == null) return;

    emit(state.copyWith(animeEpisode: animeEpisode));
    await Future.delayed(Duration.zero);
    // reset webview and video webview controller
    setSelectedOption(animeEpisode.links?.first);
  }

  Future<void> getNextEpisode() async {
    int index = state.animeEpisodes.indexWhere((element) =>
        element?.episodeNumber == state.animeEpisode.episodeNumber);
    if (index == state.animeEpisodes.length - 1) return;
    AnimeEpisode? animeEpisode = state.animeEpisodes[index + 1];
    if (animeEpisode == null) return;

    emit(state.copyWith(animeEpisode: animeEpisode));
    await Future.delayed(Duration.zero);

    setSelectedOption(animeEpisode.links?.first);
  }

  Future<void> setSelectedOption(Links? value) async {
    if (value == null) return;

    emit(state.copyWith(selectedOption: value));
    await Future.delayed(Duration.zero);
    setIsVideoLoading(true);
    await Future.delayed(Duration(milliseconds: 500));
    // await webViewController?.loadUrl(
    //     urlRequest: URLRequest(url: Uri.parse(value.url!)));
    setIsVideoLoading(false);
  }

  void setIsVideoLoading(bool value) {
    emit(state.copyWith(isVideoLoading: value));
  }
}
