part of 'wallpaper_cubit.dart';

// enum WallpaperStatus { initial, loading, success, failure }
enum GridState {
  ONE,
  TWO,
  FOUR,
}

class WallpaperState extends Equatable {
  List<AnimeNameModel> animeNames;
  String filterWord;
  WallpaperModel? selectedWallpaper;
  bool isLoading;
  GridState gridState;
  List<WallpaperModel> wallpaperModels;
  List<WallpaperModel> filteredWallpapers;
  List<int> downloadingImages;
  List<int> settingWallpapers;

  int paginationCount;
  int paginationLimit;

  WallpaperState(
      {this.isLoading = false,
      this.animeNames = const [],
      this.filteredWallpapers = const [],
      this.selectedWallpaper,
      this.filterWord = "",
      this.paginationCount = 0,
      this.paginationLimit = 30,
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
        filteredWallpapers,
        filterWord,
        paginationCount,
        paginationLimit
      ];

  WallpaperState copyWith({
    bool? isLoading,
    List<WallpaperModel>? wallpaperModels,
    List<int>? settingWallpapers,
    GridState? gridState,
    WallpaperModel? selectedWallpaper,
    List<int>? downloadingImages,
    List<AnimeNameModel>? animeNames,
    String? filterWord,
    List<WallpaperModel>? filteredWallpapers,
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
      filteredWallpapers: filteredWallpapers ?? this.filteredWallpapers,
      filterWord: filterWord ?? this.filterWord,
      paginationCount: paginationCount ?? this.paginationCount,
      paginationLimit: paginationLimit ?? this.paginationLimit,
    );
  }
}
