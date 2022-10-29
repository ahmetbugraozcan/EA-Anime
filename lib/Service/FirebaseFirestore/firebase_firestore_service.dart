import 'package:cloud_firestore/cloud_firestore.dart';
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
}
