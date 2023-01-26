import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterglobal/Models/anime.dart';
import 'package:flutterglobal/Models/anime_episode.dart';
import 'package:flutterglobal/Models/blog_model.dart';
import 'package:flutterglobal/Models/knowledge_test_model.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/i_firebase_firestore.dart';

class FirebaseFireStoreService extends IFirebaseFirestoreService {
  static FirebaseFireStoreService? _instance;

  // DatabaseReference ref = FirebaseDatabase.instance.ref();
  static FirebaseFireStoreService get instance {
    return _instance ??= FirebaseFireStoreService._init();
  }

  FirebaseFireStoreService._init();

  Future<List<BlogModel>?> getBlogs() async {
    CollectionReference ref = firestore.collection("blogs");

    var data = await ref.get();
    if (data.docs.isNotEmpty) {
      List<BlogModel> list = [];
      data.docs.forEach((element) {
        list.add(BlogModel.fromJson(element.data() as Map<String, dynamic>));
      });
      return list;
    }
    return null;
  }

  Future<List<KnowledgeTestModel>?>? getKnowledgeTestModels() async {
    CollectionReference ref = firestore.collection("knowledgeTests");

    var data = await ref.get();
    if (data.docs.isNotEmpty) {
      List<KnowledgeTestModel> list = [];
      data.docs.forEach((element) {
        list.add(KnowledgeTestModel.fromJson(
            element.data() as Map<String, dynamic>));
      });
      return list;
    }
    return null;
  }

  Future<List<Anime>> getAnimeList() async {
    CollectionReference ref = firestore.collection("animes");

    var data = await ref.get();

    if (data.docs.isNotEmpty) {
      List<Anime> list = [];
      data.docs.forEach((element) {
        log(jsonEncode(element.data()));
        list.add(Anime.fromJson(element.data() as Map<String, dynamic>));
      });
      return list;
    }
    return [];
  }

  Future<List<AnimeEpisode>> getAnimeEpisodes() async {
    var ref = firestore.collection("animeEpisodes");

    var data = await ref.get();

    if (data.docs.isEmpty) return [];

    List<AnimeEpisode> list = [];
    data.docs.forEach((element) {
      list.add(AnimeEpisode.fromJson(element.data()));
    });
    return list;
  }

  Future<List<AnimeEpisode>> getAnimeEpisodesForAnime(String? id) async {
    if (id == null) return [];
    var ref =
        firestore.collection("animeEpisodes").where("animeId", isEqualTo: id);

    var data = await ref.get();

    if (data.docs.isNotEmpty) {
      List<AnimeEpisode> list = [];
      data.docs.forEach((element) {
        list.add(AnimeEpisode.fromJson(element.data()));
      });
      return list;
    }
    return [];
  }
}
