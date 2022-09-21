import 'package:equatable/equatable.dart';

class GuessingModel {
  String? animeTitle;
  String? guessingWord;
  List<HintImages>? hintImages;
  String? mainImage;

  GuessingModel({
    this.animeTitle,
    this.guessingWord,
    this.hintImages,
    this.mainImage,
  });

  GuessingModel copyWith({
    String? animeTitle,
    String? guessingWord,
    List<HintImages>? hintImages,
    String? mainImage,
  }) {
    return GuessingModel(
      animeTitle: animeTitle ?? this.animeTitle,
      guessingWord: guessingWord ?? this.guessingWord,
      hintImages: hintImages ?? this.hintImages,
      mainImage: mainImage ?? this.mainImage,
    );
  }

  GuessingModel.fromJson(Map<String, dynamic> json) {
    animeTitle = json['animeTitle'];
    guessingWord = json['guessingWord'];
    if (json['hintImages'] != null) {
      hintImages = <HintImages>[];
      json['hintImages'].forEach((v) {
        hintImages!.add(new HintImages.fromJson(v));
      });
    }
    mainImage = json['mainImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['animeTitle'] = this.animeTitle;
    data['guessingWord'] = this.guessingWord;
    if (this.hintImages != null) {
      data['hintImages'] = this.hintImages!.map((v) => v.toJson()).toList();
    }
    data['mainImage'] = this.mainImage;
    return data;
  }
}

class HintImages {
  String? url;
  bool? isLocked;

  HintImages({this.url, this.isLocked});

  HintImages.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    isLocked = json['isLocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['isLocked'] = this.isLocked;
    return data;
  }
}
