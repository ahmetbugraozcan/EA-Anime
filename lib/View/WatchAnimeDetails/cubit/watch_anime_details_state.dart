import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/anime.dart';
import 'package:flutterglobal/Models/anime_episode.dart';

class WatchAnimeDetailsState extends Equatable {
  final bool isVideoLoading;
  final AnimeEpisode animeEpisode;

  final Links? selectedOption;
  final List<AnimeEpisode?> animeEpisodes;

  WatchAnimeDetailsState({
    this.isVideoLoading = true,
    this.animeEpisodes = const [],
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
      ];

  WatchAnimeDetailsState copyWith({
    bool? isVideoLoading,
    AnimeEpisode? animeEpisode,
    Links? selectedOption,
    List<AnimeEpisode?>? animeEpisodes,
  }) {
    return WatchAnimeDetailsState(
      isVideoLoading: isVideoLoading ?? this.isVideoLoading,
      animeEpisode: animeEpisode ?? this.animeEpisode,
      selectedOption: selectedOption ?? this.selectedOption,
      animeEpisodes: animeEpisodes ?? this.animeEpisodes,
    );
  }
}
