import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/anime.dart';
import 'package:flutterglobal/Models/anime_episode.dart';

class AnimeDetailsState extends Equatable {
  final bool isRelatedAnimesLoading;
  final bool isAnimeEpisodesLoading;
  final List<Anime> relatedAnimes;
  final List<AnimeEpisode> animeEpisodes;

  AnimeDetailsState({
    this.isRelatedAnimesLoading = true,
    this.isAnimeEpisodesLoading = true,
    this.relatedAnimes = const [],
    this.animeEpisodes = const [],
  });

  @override
  List<Object?> get props => [
        isRelatedAnimesLoading,
        isAnimeEpisodesLoading,
        relatedAnimes,
        animeEpisodes,
      ];
}
