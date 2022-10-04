class AnimeNameModel {
  String? animeName;
  String? imageUrl;

  AnimeNameModel({this.animeName, this.imageUrl});

  AnimeNameModel.fromJson(Map<String, dynamic> json) {
    animeName = json['animeName'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['animeName'] = this.animeName;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
