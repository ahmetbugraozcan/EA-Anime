class KnowledgeTestModel {
  String? quizId;
  String? quizImage;
  List<Questions>? questions;
  String? quizTitle;
  String? quizDescription;
  String? createdAt;

  KnowledgeTestModel(
      {this.quizId,
      this.quizImage,
      this.questions,
      this.quizTitle,
      this.quizDescription,
      this.createdAt});

  KnowledgeTestModel.fromJson(Map<String, dynamic> json) {
    quizId = json['quizId'];
    quizImage = json['quizImage'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    quizTitle = json['quizTitle'];
    quizDescription = json['quizDescription'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quizId'] = this.quizId;
    data['quizImage'] = this.quizImage;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['quizTitle'] = this.quizTitle;
    data['quizDescription'] = this.quizDescription;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Questions {
  String? question;
  List<Answers>? answers;
  String? imageUrl;

  Questions({this.question, this.answers, this.imageUrl});

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(new Answers.fromJson(v));
      });
    }
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class Answers {
  String? answer;
  bool? isCorrect;

  Answers({this.answer, this.isCorrect});

  Answers.fromJson(Map<String, dynamic> json) {
    answer = json['answer'];
    isCorrect = json['isCorrect'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['answer'] = this.answer;
    data['isCorrect'] = this.isCorrect;
    return data;
  }
}
