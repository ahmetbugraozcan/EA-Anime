import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Init/Cache/locale_manager.dart';
import 'package:flutterglobal/Models/knowledge_test_model.dart';
import 'package:flutterglobal/Models/blog_model.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/i_firebase_firestore.dart';

class FirebaseFirestoreI18 extends IFirebaseFirestoreService {
  static FirebaseFirestoreI18? _instance;
  static FirebaseFirestoreI18 get instance =>
      _instance ??= FirebaseFirestoreI18._init();

  FirebaseFirestoreI18._init();
  @override
  Future<List<BlogModel>?> getBlogs() async {
    CollectionReference ref =
        CacheManager.instance.getStringValue(PreferencesKeys.LANGUAGE) ==
                LanguageEnums.EN.name
            ? firestore.collection("blogsEnglish")
            : firestore.collection("blogs");

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

  @override
  Future<List<KnowledgeTestModel>?>? getKnowledgeTestModels() async {
    CollectionReference ref =
        CacheManager.instance.getStringValue(PreferencesKeys.LANGUAGE) ==
                LanguageEnums.EN.name
            ? firestore.collection("englishKnowledgeTests")
            : firestore.collection("knowledgeTests");

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
}
