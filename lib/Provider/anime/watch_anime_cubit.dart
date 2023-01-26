import 'package:bloc/bloc.dart';
import 'package:flutterglobal/Provider/anime/watch_anime_state.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/firebase_firestore_service.dart';

class WatchAnimeCubit extends Cubit<WatchAnimeState> {
  WatchAnimeCubit() : super(WatchAnimeState()) {
    getLastAddedAnimeEpisodes();
    getAnimeList();
  }

  void getLastAddedAnimeEpisodes() async {
    emit(state.copyWith(isLoading: true));
    var animelist = await FirebaseFireStoreService.instance.getAnimeEpisodes();

    emit(state.copyWith(animeEpisodeList: animelist, isLoading: false));
  }

  Future<void> getAnimeList() async {
    emit(state.copyWith(isAnimeListLoading: true));
    var value = await FirebaseFireStoreService.instance.getAnimeList();
    emit(state.copyWith(animeList: value, isAnimeListLoading: false));
  }
}
