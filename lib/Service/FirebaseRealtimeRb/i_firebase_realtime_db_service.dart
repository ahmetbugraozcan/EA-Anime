import 'package:firebase_database/firebase_database.dart';
import 'package:flutterglobal/Models/anime_name_model.dart';
import 'package:flutterglobal/Models/personality_test_model.dart';
import 'package:flutterglobal/Models/wallpaper_model.dart';

abstract class IFirebaseRealtimeDBService {
  Future<List<PersonalityTestModel>?> getPersonalityQuestionsData();

  Future<List<WallpaperModel>?> gelWallpaperData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("wallpapers/");

    var data = await ref.get();
    if (data.exists) {
      Map<String, dynamic> jsonData = Map.from(data.value as Map);

      List<WallpaperModel> list = [];
      ((jsonData["images"] as List).reversed).forEach((element) {
        list.add(WallpaperModel.fromJson(Map.from(element as Map)));
      });

      return list;
    }
    return null;
  }

  Future<List<AnimeNameModel>> getAnimeNames() {
    DatabaseReference ref = FirebaseDatabase.instance.ref("animeNames");

    var data = ref.once();
    return data.then((value) {
      List<AnimeNameModel> list = [];
      print(value.snapshot.value);
      (value.snapshot.value as List).forEach((element) {
        list.add(AnimeNameModel.fromJson(Map.from(element as Map)));
      });
      return list;
    });
  }
}
