class Level {
  String levelId;
  int questionIndex;

  Level({required this.levelId, this.questionIndex = 0});

  Level copyWith({
    String? levelId,
    int? questionIndex,
  }) {
    return Level(
      levelId: levelId ?? this.levelId,
      questionIndex: questionIndex ?? this.questionIndex,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'levelId': levelId,
      'questionIndex': questionIndex,
    };
  }

  factory Level.fromJson(Map<String, dynamic> map) {
    return Level(
      levelId: map['levelId'],
      questionIndex: map['questionIndex'],
    );
  }
}
