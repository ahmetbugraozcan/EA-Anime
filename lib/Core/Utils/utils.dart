import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Constants/app_constants.dart';
import 'package:flutterglobal/Service/wallpaper_manager_service.dart';

class Utils {
  // make lazy singleton class
  static Utils? _instance;

  Random _rnd = Random();
  Utils._init();

  static Utils get instance {
    return _instance ??= Utils._init();
  }

  String getJPGImage(ImageEnums imageEnums) {
    return "${AssetEnums.assets.name}/${AssetEnums.images.name}/${imageEnums.name}.jpg";
  }

  String getPNGImage(ImageEnums imageEnums) {
    return "${AssetEnums.assets.name}/${AssetEnums.images.name}/${imageEnums.name}.png";
  }

  String getLottiePath(LottieEnums lottieEnums) {
    return AppConstants.instance.LOTTIE_ASSET_PATH +
        "/${lottieEnums.name}.json";
  }

  BoxDecoration backgroundDecoration(ImageEnums image,
      {BoxFit fit = BoxFit.cover}) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
          getJPGImage(image),
        ),
        fit: fit,
      ),
    );
  }

  List<String> getShuffeledRandomList(String shuffleText, int size) {
    List<String> list = [];
    for (int i = 0; i < shuffleText.length; i++) {
      list.add(shuffleText[i].toUpperCase());
    }

    for (int i = 0; i < size - shuffleText.length; i++) {
      list.add(AppConstants.instance.upperCaseChars[
          _rnd.nextInt(AppConstants.instance.upperCaseChars.length)]);
    }

    list.shuffle();

    String a = "";
    list.forEach((element) {
      a += element;
    });

    print(a);
    return list;
  }

  String getWallpaperTypeString(WallpaperType wallpaperType) {
    switch (wallpaperType) {
      case WallpaperType.BOTH_SCREENS:
        return "Her ikisi";
      case WallpaperType.HOME_SCREEN:
        return "Ana Ekran";
      case WallpaperType.LOCK_SCREEN:
        return "Kilit Ekranı";
      default:
        return "Photo";
    }
  }
}
