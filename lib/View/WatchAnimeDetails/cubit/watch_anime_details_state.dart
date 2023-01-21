import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/anime_episode.dart';

class WatchAnimeDetailsState extends Equatable {
  final bool isVideoLoading;
  final AnimeEpisode animeEpisode;

  WatchAnimeDetailsState({
    this.isVideoLoading = false,
    required this.animeEpisode,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [isVideoLoading, animeEpisode];

  WatchAnimeDetailsState copyWith({
    bool? isVideoLoading,
    AnimeEpisode? animeEpisode,
  }) {
    return WatchAnimeDetailsState(
      isVideoLoading: isVideoLoading ?? this.isVideoLoading,
      animeEpisode: animeEpisode ?? this.animeEpisode,
    );
  }
}
