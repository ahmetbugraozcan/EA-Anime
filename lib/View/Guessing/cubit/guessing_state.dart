part of 'guessing_cubit.dart';

class GuessingState extends Equatable {
  bool isLoading;
  bool isAnsweredWrong;
  bool isPanelActive;
  bool isAnimeTitleActive;
  List<GuessingModel> guessingModels;
  int questionIndex;
  List<GuessCardModel> shuffeledList;
  List<GuessCardModel?> userGuessedWords;
  GuessingState(
      {this.isLoading = false,
      this.isAnimeTitleActive = false,
      this.guessingModels = const [],
      this.shuffeledList = const [],
      this.userGuessedWords = const [],
      this.questionIndex = 0,
      this.isPanelActive = false,
      this.isAnsweredWrong = false});

  GuessingState copyWith(
      {bool? isLoading,
      List<GuessingModel>? guessingModels,
      List<GuessCardModel>? shuffeledList,
      List<GuessCardModel?>? userGuessedWords,
      bool? isAnimeTitleActive,
      bool? isPanelActive,
      int? questionIndex,
      bool? isAnsweredWrong}) {
    return GuessingState(
      isLoading: isLoading ?? this.isLoading,
      isAnimeTitleActive: isAnimeTitleActive ?? this.isAnimeTitleActive,
      questionIndex: questionIndex ?? this.questionIndex,
      userGuessedWords: userGuessedWords ?? this.userGuessedWords,
      shuffeledList: shuffeledList ?? this.shuffeledList,
      guessingModels: guessingModels ?? this.guessingModels,
      isPanelActive: isPanelActive ?? this.isPanelActive,
      isAnsweredWrong: isAnsweredWrong ?? this.isAnsweredWrong,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isAnsweredWrong,
        isPanelActive,
        isAnimeTitleActive,
        guessingModels,
        questionIndex,
        shuffeledList,
        userGuessedWords
      ];
}
