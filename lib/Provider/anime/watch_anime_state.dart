import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/anime.dart';
import 'package:flutterglobal/Models/anime_episode.dart';

class WatchAnimeState extends Equatable {
  bool isLoading = false;
  List<Anime> animeList = [];
  List<AnimeEpisode> animeEpisodeList = [];

  WatchAnimeState(
      {this.isLoading = false,
      this.animeList = const [],
      this.animeEpisodeList = const []});

  WatchAnimeState copyWith(
      {bool? isLoading,
      List<Anime>? animeList,
      List<AnimeEpisode>? animeEpisodeList}) {
    return WatchAnimeState(
        isLoading: isLoading ?? this.isLoading,
        animeList: animeList ?? this.animeList,
        animeEpisodeList: animeEpisodeList ?? this.animeEpisodeList);
  }

  @override
  List<Object?> get props => [isLoading, animeList, animeEpisodeList];
}
