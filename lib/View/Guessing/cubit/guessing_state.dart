part of 'guessing_cubit.dart';

class GuessingState extends Equatable {
  bool isLoading;
  bool isAnsweredWrong;
  bool isPanelActive;
  bool isAnimeTitleActive;
  int questionIndex;
  List<GuessCardModel> shuffeledList;
  List<GuessCardModel?> userGuessedWords;
  GuessingModel? guessingModel;
  GuessingState(
      {this.isAnimeTitleActive = false,
      this.shuffeledList = const [],
      this.userGuessedWords = const [],
      this.questionIndex = 0,
      this.isPanelActive = false,
      this.isLoading = false,
      this.guessingModel,
      this.isAnsweredWrong = false});

  GuessingState copyWith(
      {bool? isLoading,
      List<GuessCardModel>? shuffeledList,
      List<GuessCardModel?>? userGuessedWords,
      bool? isAnimeTitleActive,
      bool? isPanelActive,
      int? questionIndex,
      GuessingModel? guessingModel,
      bool? isAnsweredWrong}) {
    return GuessingState(
      isAnimeTitleActive: isAnimeTitleActive ?? this.isAnimeTitleActive,
      questionIndex: questionIndex ?? this.questionIndex,
      userGuessedWords: userGuessedWords ?? this.userGuessedWords,
      shuffeledList: shuffeledList ?? this.shuffeledList,
      isPanelActive: isPanelActive ?? this.isPanelActive,
      isAnsweredWrong: isAnsweredWrong ?? this.isAnsweredWrong,
      guessingModel: guessingModel ?? this.guessingModel,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        isAnsweredWrong,
        isPanelActive,
        isAnimeTitleActive,
        questionIndex,
        shuffeledList,
        userGuessedWords,
        guessingModel,
        isLoading
      ];
}
