import 'package:cloud_firestore/cloud_firestore.dart';

class StickerPackModel {
  String? name;
  Timestamp? createDate;
  String? uuid;
  String? mainPhoto;

  List<String>? stickerUrls;

  StickerPackModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    this.name = json["name"];
    this.uuid = json["uuid"];
    this.stickerUrls = json["stickerUrls"].cast<String>();
    this.createDate =
        json["createDate"] is Timestamp ? json["createDate"] : null;
    this.mainPhoto = json["mainPhoto"];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map["name"] = this.name;
    map["uuid"] = this.uuid;
    map["stickerUrls"] = this.stickerUrls;
    map["createDate"] = this.createDate;
    map["mainPhoto"] = this.mainPhoto;

    return map;
  }
}
