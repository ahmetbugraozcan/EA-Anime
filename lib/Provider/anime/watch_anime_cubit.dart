import 'package:bloc/bloc.dart';
import 'package:flutterglobal/Provider/anime/watch_anime_state.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/firebase_firestore_service.dart';

class WatchAnimeCubit extends Cubit<WatchAnimeState> {
  WatchAnimeCubit() : super(WatchAnimeState()) {
    getAnimeList();
  }

  void getAnimeList() async {
    emit(state.copyWith(isLoading: true));
    await FirebaseFireStoreService.instance.getAnimeList();
    emit(state.copyWith(isLoading: false));
  }
}
