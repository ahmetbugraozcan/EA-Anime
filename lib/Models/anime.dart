class Anime {
  String? thumbnail;
  List<String>? relatedAnimes;
  String? id;
  String? title;
  int? episodesCount;
  String? description;
  String? genre;

  Anime(
      {this.thumbnail,
      this.relatedAnimes,
      this.id,
      this.title,
      this.episodesCount,
      this.description,
      this.genre});

  Anime.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    relatedAnimes = json['relatedAnimes'].cast<String>();
    id = json['id'];
    title = json['title'];
    episodesCount = json['episodesCount'];
    description = json['description'];
    genre = json['genre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['relatedAnimes'] = this.relatedAnimes;
    data['id'] = this.id;
    data['title'] = this.title;
    data['episodesCount'] = this.episodesCount;
    data['description'] = this.description;
    data['genre'] = this.genre;
    return data;
  }
}
