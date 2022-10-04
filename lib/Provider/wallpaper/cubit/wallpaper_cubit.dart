import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Init/Cache/locale_manager.dart';
import 'package:flutterglobal/Models/anime_name_model.dart';
import 'package:flutterglobal/Models/wallpaper_model.dart';
import 'package:flutterglobal/Service/firebase_realtime_db_service.dart';
import 'package:flutterglobal/Service/image_downloader_service.dart';
import 'package:flutterglobal/Service/wallpaper_manager_service.dart';

part 'wallpaper_state.dart';

class WallpaperCubit extends Cubit<WallpaperState> {
  CacheManager _cacheManager = CacheManager.instance;

  FirebaseRealtimeDBService _firebaseRealtimeDBService =
      FirebaseRealtimeDBService.instance;

  ImageDownloaderService _imageDownloaderService =
      ImageDownloaderService.instance;

  WallpaperManagerService _wallpaperManagerService =
      WallpaperManagerService.instance;

  WallpaperCubit() : super(WallpaperState()) {
    getWallpaperData();
    getAnimeNames();
  }

  Future<void> getWallpaperData() async {
    setIsLoading(true);

    List<WallpaperModel>? model =
        await _firebaseRealtimeDBService.gelWallpaperData();
    // var a = Future.delayed(Duration(seconds: 2));
    // // a.asStream().
    if (model != null) {
      emit(state.copyWith(
          wallpaperModels: model,
          paginationCount: state.paginationCount + state.paginationLimit));
    }

    setIsLoading(false);
  }

  void onPagination() {
    emit(
      state.copyWith(
          paginationCount: state.paginationCount + state.paginationLimit),
    );
  }

  void changeGridState(GridState gridState) {
    emit(state.copyWith(gridState: gridState));
  }

  void switchGridState() {
    if (state.gridState == GridState.ONE) {
      emit(state.copyWith(gridState: GridState.TWO));
    } else if (state.gridState == GridState.TWO) {
      emit(state.copyWith(gridState: GridState.ONE));
    }
  }

  Future<bool> willShowAd() async {
    int downloadCount =
        _cacheManager.getIntValue(PreferencesKeys.DOWNLOAD_COUNT);

    if (downloadCount >= 3) {
      // show ads
      await _cacheManager.setIntValue(PreferencesKeys.DOWNLOAD_COUNT, 0);
      return true;
    } else {
      await _cacheManager.setIntValue(
          PreferencesKeys.DOWNLOAD_COUNT, downloadCount + 1);
      return false;
    }
  }

  Future<bool> downloadImage(int? id, String? url) async {
    if (id == null || url == null) return false;

    emit(state.copyWith(
        downloadingImages: List.from(state.downloadingImages)..add(id)));

    bool isDownloaded = await _imageDownloaderService.downloadImage(url);

    emit(state.copyWith(
        downloadingImages: List.from(state.downloadingImages)..remove(id)));

    return isDownloaded;
  }

  Future<bool> setWallpaper(
      int? id, String? url, WallpaperType wallpaperType) async {
    if (id == null || url == null) return false;
    emit(state.copyWith(
        settingWallpapers: List.from(state.settingWallpapers)..add(id)));

    bool isDownloaded =
        await _wallpaperManagerService.setWallpaper(url, wallpaperType);

    emit(state.copyWith(
        settingWallpapers: List.from(state.settingWallpapers)..remove(id)));

    return isDownloaded;
  }

  void _switchLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void selectWallpaper(WallpaperModel? wallpaperModel) {
    emit(state.copyWith(selectedWallpaper: wallpaperModel));
  }

  void setAnimeNames(List<AnimeNameModel> animeNames) {
    emit(state.copyWith(animeNames: animeNames));
  }

  void setIsLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  Future<void> getAnimeNames() async {
    setIsLoading(true);
    List<AnimeNameModel> animeNames =
        await _firebaseRealtimeDBService.getAnimeNames();
    setAnimeNames(animeNames);
    setIsLoading(false);
  }

  void filterWallpapersWithAnimeName(String animeName) {
    List<WallpaperModel> filteredWallpapers =
        state.wallpaperModels.where((element) {
      return element.animeName == animeName ||
          element.tags!.any((element) => element == animeName);
    }).toList();

    emit(
      state.copyWith(
        filteredWallpapers: filteredWallpapers,
        filterWord: animeName,
        paginationCount: state.paginationLimit,
      ),
    );
  }

  void setFilterWord(String? filterWord) {
    emit(state.copyWith(filterWord: filterWord));
  }
}
