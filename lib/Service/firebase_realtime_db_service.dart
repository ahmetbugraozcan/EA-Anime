import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutterglobal/Models/anime_name_model.dart';
import 'package:flutterglobal/Models/guessing_data_model.dart';
import 'package:flutterglobal/Models/guessing_model.dart';
import 'package:flutterglobal/Models/personality_test_model.dart';
import 'package:flutterglobal/Models/wallpaper_model.dart';

class FirebaseRealtimeDBService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  static FirebaseRealtimeDBService? _instance;

  // DatabaseReference ref = FirebaseDatabase.instance.ref();

  static FirebaseRealtimeDBService get instance {
    return _instance ??= FirebaseRealtimeDBService._init();
  }

  FirebaseRealtimeDBService._init();

  Future<GuessingDataModel?> getDatas() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("guessingData");

    print("data start");
    var data = await ref.get();

    if (data.exists) {
      Map<String, dynamic> jsonData = Map.from(data.value as Map);
      print((data.value as Map)["data"]);
      return GuessingDataModel.fromJson(jsonData);
    }
    return null;
  }

  Future<List<PersonalityTestModel>?> getPersonalityQuestionsData() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("tests/personality/personalityTest/");

    var data = await ref.get();
    if (data.exists) {
      Map<String, dynamic> jsonData = Map.from(data.value as Map);

      List<PersonalityTestModel> list = [];
      (jsonData["data"] as List).forEach((element) {
        if (element == null) return;
        list.add(PersonalityTestModel.fromJson(Map.from(element as Map)));
      });

      return list;
    }
    return null;
  }

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
