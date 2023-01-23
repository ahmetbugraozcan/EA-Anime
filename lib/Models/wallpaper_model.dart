class WallpaperModel {
  String? animeName;
  List<String>? tags;
  String? imageUrl;
  String? id;

  WallpaperModel({this.animeName, this.tags, this.imageUrl, this.id});

  WallpaperModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;

    animeName = json['animeName'];
    tags = json['tags'] == null ? [] : json['tags'].cast<String>();
    imageUrl = json['imageUrl'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['animeName'] = this.animeName;
    data['tags'] = this.tags;
    data['imageUrl'] = this.imageUrl;
    data['id'] = this.id;
    return data;
  }
}
