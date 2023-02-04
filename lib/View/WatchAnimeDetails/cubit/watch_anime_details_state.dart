import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/anime.dart';
import 'package:flutterglobal/Models/anime_episode.dart';

class WatchAnimeDetailsState extends Equatable {
  final bool isVideoLoading;
  final AnimeEpisode animeEpisode;
  final Anime? parentAnime;
  final Links? selectedOption;
  final bool isAnimeEpisodesLoading;
  final bool isParentAnimeLoading;
  final List<AnimeEpisode?> animeEpisodes;

  WatchAnimeDetailsState({
    this.isVideoLoading = true,
    this.animeEpisodes = const [],
    this.parentAnime,
    this.isAnimeEpisodesLoading = true,
    this.isParentAnimeLoading = true,
    required this.animeEpisode,
    required this.selectedOption,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        isVideoLoading,
        animeEpisode,
        selectedOption,
        animeEpisodes,
        parentAnime,
        isParentAnimeLoading,
        isAnimeEpisodesLoading
      ];

  WatchAnimeDetailsState copyWith({
    bool? isVideoLoading,
    AnimeEpisode? animeEpisode,
    Links? selectedOption,
    List<AnimeEpisode?>? animeEpisodes,
    Anime? parentAnime,
    bool? isParentAnimeLoading,
    bool? isAnimeEpisodesLoading,
  }) {
    return WatchAnimeDetailsState(
      isVideoLoading: isVideoLoading ?? this.isVideoLoading,
      animeEpisode: animeEpisode ?? this.animeEpisode,
      selectedOption: selectedOption ?? this.selectedOption,
      animeEpisodes: animeEpisodes ?? this.animeEpisodes,
      parentAnime: parentAnime ?? this.parentAnime,
      isParentAnimeLoading: isParentAnimeLoading ?? this.isParentAnimeLoading,
      isAnimeEpisodesLoading:
          isAnimeEpisodesLoading ?? this.isAnimeEpisodesLoading,
    );
  }
}
