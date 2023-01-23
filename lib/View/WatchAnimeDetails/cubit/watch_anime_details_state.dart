import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/anime_episode.dart';
import 'package:video_player/video_player.dart';

class WatchAnimeDetailsState extends Equatable {
  final bool isVideoLoading;
  final AnimeEpisode animeEpisode;
  final Links? selectedOption;
  final VideoPlayerController? controller;

  WatchAnimeDetailsState({
    this.isVideoLoading = true,
    required this.animeEpisode,
    required this.selectedOption,
    this.controller,
  });

  @override
  // TODO: implement props
  List<Object?> get props =>
      [isVideoLoading, animeEpisode, selectedOption, controller];

  WatchAnimeDetailsState copyWith({
    bool? isVideoLoading,
    AnimeEpisode? animeEpisode,
    Links? selectedOption,
    VideoPlayerController? controller,
  }) {
    return WatchAnimeDetailsState(
      isVideoLoading: isVideoLoading ?? this.isVideoLoading,
      animeEpisode: animeEpisode ?? this.animeEpisode,
      selectedOption: selectedOption ?? this.selectedOption,
      controller: controller ?? this.controller,
    );
  }
}
