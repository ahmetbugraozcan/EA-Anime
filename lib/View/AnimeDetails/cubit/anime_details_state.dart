import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/anime.dart';
import 'package:flutterglobal/Models/anime_episode.dart';

class AnimeDetailsState extends Equatable {
  final bool isRelatedAnimesLoading;
  final bool isAnimeEpisodesLoading;
  final bool isAnimeLoading;
  final List<Anime> relatedAnimes;
  final List<AnimeEpisode> animeEpisodes;
  final Anime? selectedAnime;

  AnimeDetailsState({
    required this.selectedAnime,
    this.isRelatedAnimesLoading = true,
    this.isAnimeEpisodesLoading = true,
    this.relatedAnimes = const [],
    this.animeEpisodes = const [],
    this.isAnimeLoading = false,
  });

  @override
  List<Object?> get props => [
        selectedAnime,
        isRelatedAnimesLoading,
        isAnimeEpisodesLoading,
        relatedAnimes,
        animeEpisodes,
        isAnimeLoading
      ];

  AnimeDetailsState copyWith({
    bool? isRelatedAnimesLoading,
    bool? isAnimeEpisodesLoading,
    List<Anime>? relatedAnimes,
    List<AnimeEpisode>? animeEpisodes,
    Anime? selectedAnime,
    bool? isAnimeLoading,
  }) {
    return AnimeDetailsState(
      selectedAnime: selectedAnime ?? this.selectedAnime,
      isRelatedAnimesLoading:
          isRelatedAnimesLoading ?? this.isRelatedAnimesLoading,
      isAnimeEpisodesLoading:
          isAnimeEpisodesLoading ?? this.isAnimeEpisodesLoading,
      relatedAnimes: relatedAnimes ?? this.relatedAnimes,
      animeEpisodes: animeEpisodes ?? this.animeEpisodes,
      isAnimeLoading: isAnimeLoading ?? this.isAnimeLoading,
    );
  }
}
