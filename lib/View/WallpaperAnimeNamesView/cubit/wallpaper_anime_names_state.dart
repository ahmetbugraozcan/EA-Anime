part of 'wallpaper_anime_names_cubit.dart';

class WallpaperAnimeNamesState extends Equatable {
  bool isLoading;

  WallpaperAnimeNamesState({
    this.isLoading = false,
  });

  List<Object> get props => [
        isLoading,
      ];

  WallpaperAnimeNamesState copyWith({
    bool? isLoading,
  }) {
    return WallpaperAnimeNamesState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
