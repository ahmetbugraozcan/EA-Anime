import 'package:cloud_firestore/cloud_firestore.dart';

class AnimeEpisode {
  String? description;
  int? introStartMinute;
  int? introEndSecond;
  int? episodeNumber;
  String? title;
  String? animeId;
  int? introStartSecond;
  String? animeName;
  List<Links>? links;
  String? thumbnail;
  int? duration;
  int? introEndMinute;
  Timestamp? createdAt;
  String? animeImage;
  String? episodeDescription;

  AnimeEpisode(
      {this.description,
      this.introStartMinute,
      this.introEndSecond,
      this.episodeNumber,
      this.title,
      this.animeId,
      this.introStartSecond,
      this.links,
      this.animeName,
      this.thumbnail,
      this.duration,
      this.animeImage,
      this.episodeDescription,
      this.introEndMinute,
      this.createdAt});

  AnimeEpisode.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    introStartMinute = json['introStartMinute'];
    introEndSecond = json['introEndSecond'];
    episodeNumber = json['episodeNumber'];
    title = json['title'];
    episodeDescription = json['episodeDescription'];
    animeId = json['animeId'];
    animeImage = json['animeImage'];
    animeName = json['animeName'];
    introStartSecond = json['introStartSecond'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    thumbnail = json['thumbnail'];
    duration = json['duration'];
    introEndMinute = json['introEndMinute'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['introStartMinute'] = this.introStartMinute;
    data['introEndSecond'] = this.introEndSecond;
    data['episodeNumber'] = this.episodeNumber;
    data['title'] = this.title;
    data['animeId'] = this.animeId;
    data['episodeDescription'] = this.episodeDescription;
    data['introStartSecond'] = this.introStartSecond;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['animeName'] = this.animeName;
    data['animeImage'] = this.animeImage;
    data['thumbnail'] = this.thumbnail;
    data['duration'] = this.duration;
    data['introEndMinute'] = this.introEndMinute;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Links {
  String? url;
  String? option;

  Links({this.url, this.option});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['option'] = this.option;
    return data;
  }
}
