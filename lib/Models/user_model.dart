import 'package:flutterglobal/Models/level_model.dart';

class UserModel {
  int diamondCount;
  int keyCount;
  int goldCount;
  List<Level> levels;
  int timelimitHighScore;

  UserModel({
    this.diamondCount = 0,
    this.keyCount = 0,
    this.goldCount = 0,
    this.timelimitHighScore = 0,
    this.levels = const [],
  });

  UserModel copyWith({
    int? diamondCount,
    int? keyCount,
    int? goldCount,
    List<Level>? levels,
    int? timelimitHighScore,
  }) {
    return UserModel(
      diamondCount: diamondCount ?? this.diamondCount,
      keyCount: keyCount ?? this.keyCount,
      goldCount: goldCount ?? this.goldCount,
      levels: levels ?? this.levels,
      timelimitHighScore: timelimitHighScore ?? this.timelimitHighScore,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'diamondCount': diamondCount,
      'keyCount': keyCount,
      'goldCount': goldCount,
      'levels': levels.map((x) => x.toJson()).toList(),
      'timelimitHighScore': timelimitHighScore,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      diamondCount: json['diamondCount'] ?? 0,
      keyCount: json['keyCount'] ?? 0,
      goldCount: json['goldCount'] ?? 0,
      timelimitHighScore: json['timelimitHighScore'] ?? 0,
      levels: json['levels'] != null
          ? (json['levels'] as List).map((i) => Level.fromJson(i)).toList()
          : [],
    );
  }
}
