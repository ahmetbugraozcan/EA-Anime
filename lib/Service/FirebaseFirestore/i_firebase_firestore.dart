import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterglobal/Models/blog_model.dart';
import 'package:flutterglobal/Models/guessing_model.dart';
import 'package:flutterglobal/Models/knowledge_test_model.dart';
import 'package:flutterglobal/Models/sticker_pack_model.dart';
import 'package:flutterglobal/Models/wallpaper_model.dart';

abstract class IFirebaseFirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<List<BlogModel>?> getBlogs();

  Future<List<GuessingModel>?> getGuessingGameData() async {
    CollectionReference ref = firestore.collection("guessingGames");

    var data = await ref.get();
    if (data.docs.isNotEmpty) {
      List<GuessingModel> list = [];
      data.docs.forEach((element) {
        list.add(
            GuessingModel.fromJson(element.data() as Map<String, dynamic>));
      });
      return list;
    }
    return null;
  }

  Future<List<KnowledgeTestModel>?>? getKnowledgeTestModels();
  DocumentSnapshot<WallpaperModel>? lastDocument;

  Future<List<WallpaperModel>?> getWallpapersLazyLoad(
      int takeCount, String? animeName,
      {bool isFirst = false}) async {
    if (animeName == null) return null;
    CollectionReference ref = firestore.collection("compressedWallpapers");
    QuerySnapshot<WallpaperModel?> data;
    if (isFirst) lastDocument = null;
    if (lastDocument == null) {
      data = await ref
          .orderBy("id", descending: true)
          .where("animeName", isEqualTo: animeName)
          .limit(takeCount)
          .withConverter<WallpaperModel>(
              fromFirestore: (snapshot, options) =>
                  WallpaperModel.fromJson(snapshot.data()),
              toFirestore: (model, options) => model.toJson())
          .get();
    } else {
      data = await ref
          .orderBy("id", descending: true)
          .where("animeName", isEqualTo: animeName)
          .startAfterDocument(lastDocument!)
          .limit(takeCount)
          .withConverter<WallpaperModel>(
              fromFirestore: (snapshot, options) =>
                  WallpaperModel.fromJson(snapshot.data()),
              toFirestore: (model, options) => model.toJson())
          .get();
    }

    if (data.docs.isNotEmpty) {
      List<WallpaperModel> list = [];
      for (var element in data.docs) {
        if (element.data() != null) {
          list.add(element.data()!);
        }
      }

      lastDocument = data.docs.last as DocumentSnapshot<WallpaperModel>;

      return list;
    }

    return null;
  }

  Future<List<StickerPackModel>?> getStickerPacks() async {
    CollectionReference ref = firestore.collection("stickers");
    var data = await ref.get();
    if (data.docs.isNotEmpty) {
      List<StickerPackModel> list = [];
      data.docs.forEach((element) {
        list.add(
            StickerPackModel.fromJson(element.data() as Map<String, dynamic>));
      });
      return list;
    }
    return null;
  }
}
