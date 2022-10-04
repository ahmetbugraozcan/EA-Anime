class PersonalityTestModel {
  int? id;
  String? animeTitle;
  String? animeType;
  String? testTitle;
  List<Tests>? tests;
  List<Characters>? characters;
  String? testImage;

  PersonalityTestModel(
      {this.id,
      this.animeTitle,
      this.testImage,
      this.animeType,
      this.testTitle,
      this.tests,
      this.characters});

  PersonalityTestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    animeTitle = json['animeTitle'];
    animeType = json['animeType'];
    testTitle = json['testTitle'];
    testImage = json['testImage'];
    if (json['tests'] != null) {
      tests = <Tests>[];
      json['tests'].forEach((v) {
        tests!.add(new Tests.fromJson(
            Map<String, dynamic>.from(Map<String, dynamic>.from(v))));
      });
    }
    if (json['characters'] != null) {
      characters = <Characters>[];
      json['characters'].forEach((v) {
        characters!.add(new Characters.fromJson(Map<String, dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['animeTitle'] = this.animeTitle;
    data['animeType'] = this.animeType;
    data['testTitle'] = this.testTitle;
    data['testImage'] = this.testImage;
    if (this.tests != null) {
      data['tests'] = this.tests!.map((v) => v.toJson()).toList();
    }
    if (this.characters != null) {
      data['characters'] = this.characters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tests {
  String? question;
  String? imageUrl;
  List<Answers>? answers;

  Tests({this.question, this.imageUrl, this.answers});

  Tests.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    imageUrl = json['imageUrl'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(Map<String, dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['imageUrl'] = this.imageUrl;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Answers {
  String? answer;
  int? value;
  List<AnswerPoints>? answerPoints;

  Answers({this.answer, this.value, this.answerPoints});

  Answers.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    value = json['value'];
    if (json['answerPoints'] != null) {
      answerPoints = <AnswerPoints>[];
      json['answerPoints'].forEach((v) {
        answerPoints!
            .add(new AnswerPoints.fromJson(Map<String, dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['value'] = this.value;
    if (this.answerPoints != null) {
      data['answerPoints'] = this.answerPoints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnswerPoints {
  int? toCharacterId;
  int? point;

  AnswerPoints({this.toCharacterId, this.point});

  AnswerPoints.fromJson(Map<String, dynamic> json) {
    toCharacterId = json['toCharacterId'];
    if (json['point'] is String)
      point = int.parse(json['point']);
    else
      point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toCharacterId'] = this.toCharacterId;
    data['point'] = this.point;
    return data;
  }
}

class Characters {
  int? id;
  String? name;
  int? point;
  String? image;
  String? description;

  Characters({this.id, this.name, this.point, this.image, this.description});

  Characters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    point = json['point'];
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['point'] = this.point;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
