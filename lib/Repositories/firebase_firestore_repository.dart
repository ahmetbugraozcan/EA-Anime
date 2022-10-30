import 'dart:developer';

import 'package:flutterglobal/Core/Init/Cache/locale_manager.dart';
import 'package:flutterglobal/Models/knowledge_test_model.dart';
import 'package:flutterglobal/Models/blog_model.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/firebase_firestore_i18.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/firebase_firestore_service.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/i_firebase_firestore.dart';
import 'package:flutterglobal/Service/PackageInfo/package_info.dart';

class FirebaseFirestoreRepository extends IFirebaseFirestoreService {
  static FirebaseFirestoreRepository? _instance;
  static FirebaseFirestoreRepository get instance {
    if (_instance == null) _instance = FirebaseFirestoreRepository._init();
    return _instance!;
  }

  FirebaseFirestoreRepository._init();
  CacheManager _cacheManager = CacheManager.instance;

  @override
  Future<List<BlogModel>?> getBlogs() async {
    if ((int.tryParse(
                PackageInfoService.instance.packageInfo?.buildNumber ?? "0") ??
            0) <
        13) {
      return await FirebaseFireStoreService.instance.getBlogs();
    } else {
      return await FirebaseFirestoreI18.instance.getBlogs();
    }
  }

  @override
  Future<List<KnowledgeTestModel>?>? getKnowledgeTestModels() async {
    if ((int.tryParse(
                PackageInfoService.instance.packageInfo?.buildNumber ?? "0") ??
            0) <
        13) {
      return await FirebaseFireStoreService.instance.getKnowledgeTestModels();
    } else {
      return await FirebaseFirestoreI18.instance.getKnowledgeTestModels();
    }
  }
}
