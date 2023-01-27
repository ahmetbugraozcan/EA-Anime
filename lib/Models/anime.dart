import 'package:cloud_firestore/cloud_firestore.dart';

class Anime {
  String? id;
  String? description;
  List<String>? studios;
  String? myAnimeListScore;
  List<String>? relatedAnimes;
  String? title;
  int? episodesCount;
  String? rankingType;
  List<String>? genres;
  String? thumbnail;
  Timestamp? createdAt;
  String? minimumAge;

  Anime(
      {this.id,
      this.description,
      this.studios,
      this.myAnimeListScore,
      this.relatedAnimes,
      this.title,
      this.episodesCount,
      this.rankingType,
      this.genres,
      this.thumbnail,
      this.createdAt,
      this.minimumAge});

  Anime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    studios = json['studios'].cast<String>();
    myAnimeListScore = json['myAnimeListScore'];
    relatedAnimes = json['relatedAnimes'].cast<String>();
    title = json['title'];
    episodesCount = json['episodesCount'];
    rankingType = json['rankingType'];
    genres = json['genres'].cast<String>();
    thumbnail = json['thumbnail'];
    createdAt = json['createdAt'];
    minimumAge = json['minimumAge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['studios'] = this.studios;
    data['myAnimeListScore'] = this.myAnimeListScore;
    data['relatedAnimes'] = this.relatedAnimes;
    data['title'] = this.title;
    data['episodesCount'] = this.episodesCount;
    data['rankingType'] = this.rankingType;
    data['genres'] = this.genres;
    data['thumbnail'] = this.thumbnail;
    data['createdAt'] = this.createdAt;
    data['minimumAge'] = this.minimumAge;
    return data;
  }
}
