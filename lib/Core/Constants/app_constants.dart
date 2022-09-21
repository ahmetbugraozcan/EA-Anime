import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';

class AppConstants {
  static AppConstants? _instance;

  static AppConstants get instance {
    return _instance ??= AppConstants._init();
  }

  AppConstants._init();

  String get LANG_ASSET_PATH =>
      "${AssetEnums.assets.name}/${AssetEnums.language.name}";

  String get DATA_ASSET_PATH =>
      "${AssetEnums.assets.name}/${AssetEnums.data.name}/1.json";

  String get LOTTIE_ASSET_PATH =>
      "${AssetEnums.assets.name}/${AssetEnums.lottie.name}";

  String get upperCaseChars => 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
}
