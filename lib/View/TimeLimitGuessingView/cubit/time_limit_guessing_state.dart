part of 'time_limit_guessing_cubit.dart';

class TimeLimitGuessingState extends Equatable {
  List<Questions> randomQuestions;
  int timeLimit;
  final bool isTimeOut;
  int questionIndex;
  bool isAnsweredWrong;
  bool isPanelActive;
  bool isAnimeTitleActive;
  List<GuessCardModel> shuffeledList;
  List<GuessCardModel?> userGuessedWords;
  bool isAdShown;

  TimeLimitGuessingState(
      {this.timeLimit = 3,
      this.randomQuestions = const [],
      this.questionIndex = 0,
      this.isAnimeTitleActive = false,
      this.shuffeledList = const [],
      this.userGuessedWords = const [],
      this.isPanelActive = false,
      this.isAnsweredWrong = false,
      this.isTimeOut = false,
      this.isAdShown = false});

  @override
  List<Object?> get props => [
        timeLimit,
        randomQuestions,
        questionIndex,
        isAnsweredWrong,
        isPanelActive,
        isAnimeTitleActive,
        shuffeledList,
        userGuessedWords,
        isTimeOut,
        isAdShown
      ];

  TimeLimitGuessingState copyWith(
      {int? timeLimit,
      List<Questions>? randomQuestions,
      int? currentQuestionIndex,
      bool? isAnsweredWrong,
      bool? isPanelActive,
      bool? isAnimeTitleActive,
      List<GuessCardModel>? shuffeledList,
      List<GuessCardModel?>? userGuessedWords,
      bool? isTimeOut,
      bool? isAdShown}) {
    return TimeLimitGuessingState(
      timeLimit: timeLimit ?? this.timeLimit,
      randomQuestions: randomQuestions ?? this.randomQuestions,
      questionIndex: currentQuestionIndex ?? this.questionIndex,
      isAnsweredWrong: isAnsweredWrong ?? this.isAnsweredWrong,
      isPanelActive: isPanelActive ?? this.isPanelActive,
      isAnimeTitleActive: isAnimeTitleActive ?? this.isAnimeTitleActive,
      shuffeledList: shuffeledList ?? this.shuffeledList,
      userGuessedWords: userGuessedWords ?? this.userGuessedWords,
      isTimeOut: isTimeOut ?? this.isTimeOut,
      isAdShown: isAdShown ?? this.isAdShown,
    );
  }
}
