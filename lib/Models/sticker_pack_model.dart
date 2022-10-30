import 'package:cloud_firestore/cloud_firestore.dart';

class StickerPackModel {
  String? animeName;
  Timestamp? createDate;

  List<String>? stickerUrls;

  StickerPackModel.fromJson(Map<String, dynamic> json) {
    this.animeName = json["animeName"];
    this.stickerUrls = json["stickerUrls"].cast<String>();
    this.createDate = json["createDate"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["animeName"] = this.animeName;
    map["stickerUrls"] = this.stickerUrls;
    map["createDate"] = this.createDate;
    return map;
  }
}
