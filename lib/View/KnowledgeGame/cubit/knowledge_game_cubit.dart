import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/knowledge_test_model.dart';

part 'knowledge_game_state.dart';

class KnowledgeGameCubit extends Cubit<KnowledgeGameState> {
  KnowledgeTestModel knowledgeTestModel;

  KnowledgeGameCubit({required this.knowledgeTestModel})
      : super(KnowledgeGameState(knowledgeTestModel: knowledgeTestModel)) {
    emit(state.copyWith(
        answers: List.generate(
            knowledgeTestModel.questions!.length, (index) => -1)));
  }

  void increaseCurrentQuestionIndex() {
    if (state.currentQuestionIndex + 1 <
        (state.knowledgeTestModel.questions?.length ?? 0)) {
      emit(state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
      ));
    }
  }

  void decreaseCurrentQuestionIndex() {
    if (state.currentQuestionIndex - 1 >= 0) {
      emit(
          state.copyWith(currentQuestionIndex: state.currentQuestionIndex - 1));
    }
  }

  void setSelectedAnswerIndex(int index) {
    List<int?> answersTemp = List<int?>.from(state.answers);
    answersTemp[state.currentQuestionIndex] = index;

    emit(state.copyWith(selectedAnswerIndex: index, answers: answersTemp));
  }

  void onTestEnd() {
    int correctAnswerCount = 0;
    for (int i = 0; i < state.answers.length; i++) {
      if (state.answers[i] ==
          state.knowledgeTestModel.questions![i].answers
              ?.indexWhere((element) => element.isCorrect == true)) {
        correctAnswerCount++;
      }
    }

    emit(state.copyWith(
        isGameEnded: true, correctAnswerCount: correctAnswerCount));
    emit(state.copyWith(isGameEnded: true));
  }

  // reset game
  void resetGame() {
    emit(
      state.copyWith(
        answers:
            List.generate(knowledgeTestModel.questions!.length, (index) => -1),
        currentQuestionIndex: 0,
        isGameEnded: false,
        correctAnswerCount: 0,
      ),
    );
  }
}
