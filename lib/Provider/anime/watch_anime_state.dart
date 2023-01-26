import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/anime.dart';
import 'package:flutterglobal/Models/anime_episode.dart';

class WatchAnimeState extends Equatable {
  bool isLoading = false;
  bool isAnimeListLoading = false;
  List<Anime> animeList = [];
  List<AnimeEpisode> animeEpisodeList = [];

  WatchAnimeState(
      {this.isLoading = false,
      this.animeList = const [],
      this.isAnimeListLoading = false,
      this.animeEpisodeList = const []});

  WatchAnimeState copyWith(
      {bool? isLoading,
      List<Anime>? animeList,
      bool? isAnimeListLoading,
      List<AnimeEpisode>? animeEpisodeList}) {
    return WatchAnimeState(
        isLoading: isLoading ?? this.isLoading,
        animeList: animeList ?? this.animeList,
        isAnimeListLoading: isAnimeListLoading ?? this.isAnimeListLoading,
        animeEpisodeList: animeEpisodeList ?? this.animeEpisodeList);
  }

  @override
  List<Object?> get props =>
      [isLoading, animeList, animeEpisodeList, isAnimeListLoading];
}
