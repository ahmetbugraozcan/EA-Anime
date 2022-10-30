import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Init/Cache/locale_manager.dart';
import 'package:flutterglobal/Models/anime_name_model.dart';
import 'package:flutterglobal/Models/wallpaper_model.dart';
import 'package:flutterglobal/Repositories/firebase_firestore_repository.dart';
import 'package:flutterglobal/Repositories/realtime_db_repository.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/i_firebase_firestore.dart';
import 'package:flutterglobal/Service/FirebaseRealtimeRb/i_firebase_realtime_db_service.dart';
import 'package:flutterglobal/Service/image_downloader_service.dart';
import 'package:flutterglobal/Service/wallpaper_manager_service.dart';

part 'wallpaper_state.dart';

class WallpaperCubit extends Cubit<WallpaperState> {
  CacheManager _cacheManager = CacheManager.instance;

  IFirebaseFirestoreService _fireStoreService =
      FirebaseFirestoreRepository.instance;

  IFirebaseRealtimeDBService _realtimeDBService = RealtimeDBRepository.instance;

  ImageDownloaderService _imageDownloaderService =
      ImageDownloaderService.instance;

  WallpaperManagerService _wallpaperManagerService =
      WallpaperManagerService.instance;

  WallpaperCubit() : super(WallpaperState()) {
    getAnimeNames();
  }

  void resetWallpapers() {
    emit(state.copyWith(
      wallpaperModels: [],
    ));
  }

  Future<void> getWallpaperData({bool isPagination = false}) async {
    if (isPagination)
      setIsPaginationLoading(true);
    else
      setIsLoading(true);
    List<WallpaperModel> wallpapers = List.from(state.wallpaperModels);

// if ispagination false means it is first request to firebase
    List<WallpaperModel>? model = await _fireStoreService.getWallpapersLazyLoad(
        state.paginationLimit, state.selectedAnimeWallpapersName,
        isFirst: !isPagination);
    if (model != null) {
      wallpapers.addAll(model);
      emit(state.copyWith(
        wallpaperModels: wallpapers,
      ));
    }

    if (isPagination)
      setIsPaginationLoading(false);
    else
      setIsLoading(false);
  }

  void onPagination() async {
    await Future.delayed(Duration.zero);

    await getWallpaperData(isPagination: true);
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

// statede tutulabilir
  Future<bool> willShowAd() async {
    int downloadCount =
        _cacheManager.getIntValue(PreferencesKeys.DOWNLOAD_COUNT);

    if (downloadCount >= 2) {
      // show ads
      await _cacheManager.setIntValue(PreferencesKeys.DOWNLOAD_COUNT, 0);
      return true;
    } else {
      await _cacheManager.setIntValue(
          PreferencesKeys.DOWNLOAD_COUNT, downloadCount + 1);
      return false;
    }
  }

  Future<bool> downloadImage(String? id, String? url) async {
    if (id == null || url == null) return false;

    emit(state.copyWith(
        downloadingImages: List.from(state.downloadingImages)..add(id)));

    bool isDownloaded = await _imageDownloaderService.downloadImage(url);

    emit(state.copyWith(
        downloadingImages: List.from(state.downloadingImages)..remove(id)));

    return isDownloaded;
  }

  Future<bool> setWallpaper(
      String? id, String? url, WallpaperType wallpaperType) async {
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

  void setIsPaginationLoading(bool isLoading) {
    emit(state.copyWith(isPaginationLoading: isLoading));
  }

  Future<void> getAnimeNames() async {
    setIsLoading(true);
    List<AnimeNameModel> animeNames = await _realtimeDBService.getAnimeNames();
    setAnimeNames(animeNames);
    setIsLoading(false);
  }

  void setSelectedAnimeWallpapersName(String animeName) {
    emit(
      state.copyWith(
        selectedAnimeWallpapersName: animeName,
      ),
    );
  }
}
