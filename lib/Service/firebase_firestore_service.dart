import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterglobal/Models/blog_model.dart';
import 'package:flutterglobal/Models/guessing_model.dart';

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

  Future<List<GuessingModel>?> getGuessingGameData() async {
    CollectionReference ref = _firestore.collection("guessingGames");

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
}
