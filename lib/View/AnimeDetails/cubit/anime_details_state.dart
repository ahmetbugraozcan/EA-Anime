import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/anime.dart';
import 'package:flutterglobal/Models/anime_episode.dart';

class AnimeDetailsState extends Equatable {
  final bool isRelatedAnimesLoading;
  final bool isAnimeEpisodesLoading;
  final List<Anime> relatedAnimes;
  final List<AnimeEpisode> animeEpisodes;
  final Anime selectedAnime;

  AnimeDetailsState({
    required this.selectedAnime,
    this.isRelatedAnimesLoading = true,
    this.isAnimeEpisodesLoading = true,
    this.relatedAnimes = const [],
    this.animeEpisodes = const [],
  });

  @override
  List<Object?> get props => [
        selectedAnime,
        isRelatedAnimesLoading,
        isAnimeEpisodesLoading,
        relatedAnimes,
        animeEpisodes,
      ];

  AnimeDetailsState copyWith({
    bool? isRelatedAnimesLoading,
    bool? isAnimeEpisodesLoading,
    List<Anime>? relatedAnimes,
    List<AnimeEpisode>? animeEpisodes,
    Anime? selectedAnime,
  }) {
    return AnimeDetailsState(
      selectedAnime: selectedAnime ?? this.selectedAnime,
      isRelatedAnimesLoading:
          isRelatedAnimesLoading ?? this.isRelatedAnimesLoading,
      isAnimeEpisodesLoading:
          isAnimeEpisodesLoading ?? this.isAnimeEpisodesLoading,
      relatedAnimes: relatedAnimes ?? this.relatedAnimes,
      animeEpisodes: animeEpisodes ?? this.animeEpisodes,
    );
  }
}
