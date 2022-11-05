import 'package:cloud_firestore/cloud_firestore.dart';

class StickerPackModel {
  String? name;
  Timestamp? createDate;
  String? uuid;

  List<String>? stickerUrls;

  StickerPackModel.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.uuid = json["uuid"];
    this.stickerUrls = json["stickerUrls"].cast<String>();
    this.createDate = json["createDate"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["name"] = this.name;
    map["uuid"] = this.uuid;
    map["stickerUrls"] = this.stickerUrls;
    map["createDate"] = this.createDate;
    return map;
  }
}
