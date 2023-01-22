import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/anime_episode.dart';

class WatchAnimeDetailsState extends Equatable {
  final bool isWebViewLoading;
  final AnimeEpisode animeEpisode;
  final Links? selectedOption;

  WatchAnimeDetailsState({
    this.isWebViewLoading = true,
    required this.animeEpisode,
    required this.selectedOption,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [isWebViewLoading, animeEpisode];

  WatchAnimeDetailsState copyWith({
    bool? isWebViewLoading,
    AnimeEpisode? animeEpisode,
    Links? selectedOption,
  }) {
    return WatchAnimeDetailsState(
      isWebViewLoading: isWebViewLoading ?? this.isWebViewLoading,
      animeEpisode: animeEpisode ?? this.animeEpisode,
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }
}
