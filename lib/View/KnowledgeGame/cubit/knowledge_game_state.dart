part of 'knowledge_game_cubit.dart';

class KnowledgeGameState extends Equatable {
  KnowledgeTestModel knowledgeTestModel;
  int correctAnswerCount;
  List<int?> answers;
  int selectedAnswerIndex;
  int currentQuestionIndex;
  bool isGameEnded;
  KnowledgeGameState(
      {required this.knowledgeTestModel,
      this.currentQuestionIndex = 0,
      this.answers = const [],
      this.selectedAnswerIndex = -1,
      this.isGameEnded = false,
      this.correctAnswerCount = 0});

  @override
  List<Object?> get props => [
        knowledgeTestModel,
        currentQuestionIndex,
        isGameEnded,
        answers,
        selectedAnswerIndex,
        correctAnswerCount,
      ];

  KnowledgeGameState copyWith({
    KnowledgeTestModel? knowledgeTestModel,
    int? currentQuestionIndex,
    bool? isGameEnded,
    List<int?>? answers,
    int? selectedAnswerIndex,
    int? correctAnswerCount,
  }) {
    return KnowledgeGameState(
      knowledgeTestModel: knowledgeTestModel ?? this.knowledgeTestModel,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      isGameEnded: isGameEnded ?? this.isGameEnded,
      answers: answers ?? this.answers,
      selectedAnswerIndex: selectedAnswerIndex ?? this.selectedAnswerIndex,
      correctAnswerCount: correctAnswerCount ?? this.correctAnswerCount,
    );
  }
}
