import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/anime_episode.dart';

class WatchAnimeDetailsState extends Equatable {
  final bool isVideoLoading;
  final AnimeEpisode animeEpisode;
  final Links? selectedOption;

  WatchAnimeDetailsState({
    this.isVideoLoading = true,
    required this.animeEpisode,
    required this.selectedOption,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        isVideoLoading,
        animeEpisode,
        selectedOption,
      ];

  WatchAnimeDetailsState copyWith({
    bool? isVideoLoading,
    AnimeEpisode? animeEpisode,
    Links? selectedOption,
  }) {
    return WatchAnimeDetailsState(
      isVideoLoading: isVideoLoading ?? this.isVideoLoading,
      animeEpisode: animeEpisode ?? this.animeEpisode,
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }
}
