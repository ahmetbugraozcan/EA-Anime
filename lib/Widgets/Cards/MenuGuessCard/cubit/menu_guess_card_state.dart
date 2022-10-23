part of 'menu_guess_card_cubit.dart';

class MenuGuessCardState extends Equatable {
  int fontSize;

  MenuGuessCardState({
    this.fontSize = 20,
  });

  @override
  List<Object?> get props => [fontSize];

  MenuGuessCardState copyWith({
    int? fontSize,
  }) {
    return MenuGuessCardState(
      fontSize: fontSize ?? this.fontSize,
    );
  }
}
