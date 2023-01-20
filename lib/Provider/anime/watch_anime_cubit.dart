import 'package:bloc/bloc.dart';
import 'package:flutterglobal/Provider/anime/watch_anime_state.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/firebase_firestore_service.dart';

class WatchAnimeCubit extends Cubit<WatchAnimeState> {
  WatchAnimeCubit() : super(WatchAnimeState()) {
    getAnimeList();
  }

  void getAnimeList() async {
    emit(state.copyWith(isLoading: true));
    var animelist = await FirebaseFireStoreService.instance.getAnimeList();
    var anime = await FirebaseFireStoreService.instance
        .getAnimeEpisodes(animelist[1].id);
    emit(state.copyWith(animeList: animelist, isLoading: false));
  }
}
