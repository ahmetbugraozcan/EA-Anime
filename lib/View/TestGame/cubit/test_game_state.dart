part of 'test_game_cubit.dart';

class TestGameState extends Equatable {
  bool isLoading;
  bool isTestEnded;

  PersonalityTestModel? personalityTestModel;
  int currentQuestionIndex;
  List<int?> answers;
  int? selectedAnswerIndex;
  TestGameState({
    this.isLoading = false,
    this.isTestEnded = false,
    this.personalityTestModel,
    this.currentQuestionIndex = 0,
    this.answers = const [],
    this.selectedAnswerIndex,
  });

  TestGameState copyWith({
    bool? isLoading,
    PersonalityTestModel? personalityTestModel,
    int? currentQuestionIndex,
    int? currentTestIndex,
    int? selectedAnswerIndex,
    List<int?>? answers,
    bool? isTestEnded,
  }) {
    return TestGameState(
      isLoading: isLoading ?? this.isLoading,
      personalityTestModel: personalityTestModel ?? this.personalityTestModel,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
      answers: answers ?? this.answers,
      isTestEnded: isTestEnded ?? this.isTestEnded,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        personalityTestModel,
        currentQuestionIndex,
        selectedAnswerIndex,
        answers,
        isTestEnded,
      ];
}
