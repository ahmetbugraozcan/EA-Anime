part of 'wallpaper_cubit.dart';

// enum WallpaperStatus { initial, loading, success, failure }
enum GridState {
  ONE,
  TWO,
  FOUR,
}

class WallpaperState extends Equatable {
  List<AnimeNameModel> animeNames;
  String? selectedAnimeWallpapersName;

  WallpaperModel? selectedWallpaper;
  bool isLoading;
  bool isPaginationLoading;
  GridState gridState;
  List<WallpaperModel> wallpaperModels;
  List<String> downloadingImages;
  List<String> settingWallpapers;

  int paginationCount;
  int paginationLimit;

  WallpaperState(
      {this.isLoading = false,
      this.isPaginationLoading = false,
      this.selectedAnimeWallpapersName,
      this.animeNames = const [],
      this.selectedWallpaper,
      this.paginationCount = 0,
      this.paginationLimit = 15,
      this.wallpaperModels = const [],
      this.downloadingImages = const [],
      this.settingWallpapers = const [],
      this.gridState = GridState.TWO});

  @override
  List<Object?> get props => [
        isLoading,
        wallpaperModels,
        gridState,
        downloadingImages,
        settingWallpapers,
        selectedWallpaper,
        animeNames,
        paginationCount,
        paginationLimit,
        selectedAnimeWallpapersName,
      ];

  WallpaperState copyWith({
    bool? isLoading,
    bool? isPaginationLoading,
    List<WallpaperModel>? wallpaperModels,
    List<String>? settingWallpapers,
    GridState? gridState,
    WallpaperModel? selectedWallpaper,
    List<String>? downloadingImages,
    List<AnimeNameModel>? animeNames,
    String? selectedAnimeWallpapersName,
    int? paginationCount,
    int? paginationLimit,
  }) {
    return WallpaperState(
      wallpaperModels: wallpaperModels ?? this.wallpaperModels,
      isLoading: isLoading ?? this.isLoading,
      gridState: gridState ?? this.gridState,
      selectedWallpaper: selectedWallpaper ?? this.selectedWallpaper,
      downloadingImages: downloadingImages ?? this.downloadingImages,
      settingWallpapers: settingWallpapers ?? this.settingWallpapers,
      animeNames: animeNames ?? this.animeNames,
      paginationCount: paginationCount ?? this.paginationCount,
      paginationLimit: paginationLimit ?? this.paginationLimit,
      selectedAnimeWallpapersName:
          selectedAnimeWallpapersName ?? this.selectedAnimeWallpapersName,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
    );
  }
}
