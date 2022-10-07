import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  String? id;
  String? writer;
  String? content;
  List<String>? tags;
  Timestamp? date;
  String? description;
  String? title;
  String? image;

  BlogModel({this.id, this.writer, this.content, this.tags});

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    writer = json['writer'];
    content = json['content'];
    tags = json['tags'].cast<String>();
    date = json['date'];
    description = json['description'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['writer'] = this.writer;
    data['content'] = this.content;
    data['tags'] = this.tags;
    data['date'] = this.date;
    return data;
  }
}
