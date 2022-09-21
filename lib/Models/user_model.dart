class UserModel {
  int diamondCount;
  int keyCount;
  int goldCount;

  UserModel({
    this.diamondCount = 0,
    this.keyCount = 0,
    this.goldCount = 0,
  });

  UserModel copyWith({
    int? diamondCount,
    int? keyCount,
    int? goldCount,
  }) {
    return UserModel(
      diamondCount: diamondCount ?? this.diamondCount,
      keyCount: keyCount ?? this.keyCount,
      goldCount: goldCount ?? this.goldCount,
    );
  }
}
