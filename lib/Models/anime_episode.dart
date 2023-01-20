class AnimeEpisode {
  String? thumbnail;
  int? episodeNumber;
  String? title;
  List<Links>? links;
  int? duration;
  String? description;
  String? animeId;

  AnimeEpisode(
      {this.thumbnail,
      this.episodeNumber,
      this.title,
      this.links,
      this.duration,
      this.description,
      this.animeId});

  AnimeEpisode.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    episodeNumber = json['episodeNumber'];
    title = json['title'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    duration = json['duration'];
    description = json['description'];
    animeId = json['animeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['episodeNumber'] = this.episodeNumber;
    data['title'] = this.title;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['animeId'] = this.animeId;
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
