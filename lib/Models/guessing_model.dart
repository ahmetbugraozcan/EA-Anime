class GuessingModel {
  String? mainImage;
  List<Questions>? questions;
  String? id;
  String? animeName;

  GuessingModel({this.mainImage, this.questions, this.id, this.animeName});

  GuessingModel.fromJson(Map<String, dynamic> json) {
    mainImage = json['mainImage'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    id = json['id'];
    animeName = json['animeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mainImage'] = this.mainImage;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['animeName'] = this.animeName;
    return data;
  }
}

class Questions {
  String? guessingWord;
  String? imageUrl;
  List<Answers>? answers;
  String? id;

  Questions({this.guessingWord, this.imageUrl, this.answers, this.id});

  Questions.fromJson(Map<String, dynamic> json) {
    guessingWord = json['guessingWord'];
    imageUrl = json['imageUrl'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guessingWord'] = this.guessingWord;
    data['imageUrl'] = this.imageUrl;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class Answers {
  bool? isLocked;
  String? id;
  String? url;

  Answers({this.isLocked, this.id, this.url});

  Answers.fromJson(Map<String, dynamic> json) {
    isLocked = json['isLocked'];
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isLocked'] = this.isLocked;
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}
