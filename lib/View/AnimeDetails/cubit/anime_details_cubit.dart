import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Models/anime.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/firebase_firestore_service.dart';
import 'package:flutterglobal/View/AnimeDetails/cubit/anime_details_state.dart';

class AnimeDetailsCubit extends Cubit<AnimeDetailsState> {
  Anime selectedAnime;
  AnimeDetailsCubit({required this.selectedAnime})
      : super(AnimeDetailsState(selectedAnime: selectedAnime)) {
    getRelatedAnimes();
    getAnimeEpisodes();
  }

  void getAnimeEpisodes() async {
    emit(state.copyWith(isAnimeEpisodesLoading: true));
    var animeEpisodes = await FirebaseFireStoreService.instance
        .getAnimeEpisodesForAnime(selectedAnime.id);

    emit(state.copyWith(
        isAnimeEpisodesLoading: false, animeEpisodes: animeEpisodes));
  }

  void getRelatedAnimes() async {
    emit(state.copyWith(isRelatedAnimesLoading: true));
    var relatedAnimes = await FirebaseFireStoreService.instance
        .getRelatedAnimes(selectedAnime.relatedAnimes);
    emit(state.copyWith(
        isRelatedAnimesLoading: false, relatedAnimes: relatedAnimes));
  }
}


// TODO metodlar repositoryden alınacak