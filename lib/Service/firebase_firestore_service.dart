import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterglobal/Models/blog_model.dart';

class FirebaseFireStoreService {
  static FirebaseFireStoreService? _instance;

  // DatabaseReference ref = FirebaseDatabase.instance.ref();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseFireStoreService get instance {
    return _instance ??= FirebaseFireStoreService._init();
  }

  FirebaseFireStoreService._init();

  Future<List<BlogModel>?> getBlogs() async {
    CollectionReference ref = _firestore.collection("blogs");

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
}
