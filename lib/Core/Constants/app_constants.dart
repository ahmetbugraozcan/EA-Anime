import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';

class AppConstants {
  static AppConstants? _instance;

  static AppConstants get instance {
    return _instance ??= AppConstants._init();
  }

  AppConstants._init();

  String get LANG_ASSET_PATH =>
      "${AssetEnums.assets.name}/${AssetEnums.translations.name}";

  String get DATA_ASSET_PATH =>
      "${AssetEnums.assets.name}/${AssetEnums.data.name}/1.json";

  String get LOTTIE_ASSET_PATH =>
      "${AssetEnums.assets.name}/${AssetEnums.lottie.name}";

  String get upperCaseChars => 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  String get imageNotFound =>
      "https://www.slntechnologies.com/wp-content/uploads/2017/08/ef3-placeholder-image.jpg";

  int get goldCountForAnswer => 500;

  int get keyPrice => 250;

  int get defaultTimeForGuessingGame => 60;

  int get extraTimeForGuessingGameFromAd => 30;
  int get extraTimeForGuessingGameFromCorrectAnswer => 5;
}
