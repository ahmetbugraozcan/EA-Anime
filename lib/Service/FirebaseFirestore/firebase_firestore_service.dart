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

  Future<Anime> getAnime(String id) async {
    var ref = firestore.collection("animes").doc(id);

    var data = await ref.get();

    if (data.exists) {
      return Anime.fromJson(data.data()!);
    }
    return Anime();
  }

  Future<List<Anime>> getAnimeList() async {
    var ref =
        firestore.collection("animes").orderBy("createdAt", descending: true);

    var data = await ref.get();

    if (data.docs.isEmpty) return [];

    List<Anime> list = [];
    data.docs.forEach((element) {
      // log(jsonEncode(element.data()));
      list.add(Anime.fromJson(element.data()));
    });
    return list;
  }

  Future<List<AnimeEpisode>> getAnimeEpisodes() async {
    var ref = firestore
        .collection("animeEpisodes")
        .orderBy("createdAt", descending: true)
        .limit(30);

    var data = await ref.get();

    if (data.docs.isEmpty) return [];

    List<AnimeEpisode> list = [];
    data.docs.forEach((element) {
      list.add(AnimeEpisode.fromJson(element.data()));
    });
    return list;
  }

  Future<List<Anime>> getRelatedAnimes(List<String>? ids) async {
    if (ids == null) return [];
    List<Anime> list = [];

    for (var id in ids) {
      var anime = await getAnime(id);
      list.add(anime);
    }

    print("list is $list");
    return list;
  }

  Future<List<AnimeEpisode>> getAnimeEpisodesForAnime(String? id) async {
    if (id == null) return [];
    var ref = firestore
        .collection("animeEpisodes")
        .where("animeId", isEqualTo: id)
        .orderBy("episodeNumber", descending: false);

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
