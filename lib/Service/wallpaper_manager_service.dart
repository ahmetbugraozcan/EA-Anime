import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/services.dart';

enum WallpaperType { HOME_SCREEN, LOCK_SCREEN, BOTH_SCREENS }

class WallpaperManagerService {
  static WallpaperManagerService? _instance;
  static WallpaperManagerService get instance {
    return _instance ??= WallpaperManagerService._init();
  }

  WallpaperManagerService._init();

  Future<bool> setWallpaper(String url, WallpaperType wallpaperType) async {
    int location;
    String result;

    switch (wallpaperType) {
      case WallpaperType.HOME_SCREEN:
        location = AsyncWallpaper.HOME_SCREEN;
        break;
      case WallpaperType.LOCK_SCREEN:
        location = AsyncWallpaper.LOCK_SCREEN;
        break;
      case WallpaperType.BOTH_SCREENS:
        location = AsyncWallpaper.BOTH_SCREENS;
        break;
      default:
        location = AsyncWallpaper.BOTH_SCREENS;
    }

    try {
      result = await AsyncWallpaper.setWallpaper(
        url: url,
        wallpaperLocation: location,
        goToHome: false,
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';

      return true;
    } on PlatformException {
      result = 'Failed to get wallpaper.';
      print(result);
      return false;
    }
  }
}
