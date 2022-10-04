import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/personality_test_model.dart';
import 'package:flutterglobal/Service/firebase_realtime_db_service.dart';

part 'test_game_state.dart';

class TestGameCubit extends Cubit<TestGameState> {
  FirebaseRealtimeDBService _firebaseRealtimeDBService =
      FirebaseRealtimeDBService.instance;
  TestGameCubit(PersonalityTestModel personalityTestModel)
      : super(TestGameState()) {
    setPersonalityTestModel(personalityTestModel);
  }

  void setPersonalityTestModel(PersonalityTestModel personalityTestModel) {
    emit(state.copyWith(
        personalityTestModel: personalityTestModel,
        answers:
            List.generate(personalityTestModel.tests!.length, (index) => 0)));
  }

  void _switchLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void increaseCurrentQuestionIndex() {
    if (state.currentQuestionIndex + 1 <
        state.personalityTestModel!.tests!.length) {
      emit(state.copyWith(
          currentQuestionIndex: state.currentQuestionIndex + 1,
          selectedAnswerIndex: 0));
    }
  }

  void decreaseCurrentQuestionIndex() {
    if (state.currentQuestionIndex - 1 >= 0) {
      emit(
          state.copyWith(currentQuestionIndex: state.currentQuestionIndex - 1));
    }
  }

  void onEndTest() {
    if (state.personalityTestModel?.tests?.length == null) return;

    PersonalityTestModel personalityTestModel = state.personalityTestModel!;
    List<Tests>? data = personalityTestModel.tests;

// reset points
    personalityTestModel.characters?.forEach((element) {
      element.point = 0;
    });

    for (int i = 0; i < data!.length; i++) {
      data[i]
          .answers
          ?.firstWhere((answer) => answer.value == state.answers[i])
          .answerPoints
          ?.forEach((answerPoint) {
        // puan ekleme işlemi
        personalityTestModel
            .characters![personalityTestModel.characters!.indexWhere(
                (element) => element.id == answerPoint.toCharacterId)]
            .point = personalityTestModel
                .characters![personalityTestModel.characters!.indexWhere(
                    (element) => element.id == answerPoint.toCharacterId)]
                .point! +
            answerPoint.point!;
      });
    }

    personalityTestModel.characters
        ?.sort((a, b) => b.point!.compareTo(a.point!));
    personalityTestModel.characters?.forEach((element) {
      print(element.name! + " " + element.point.toString());
    });
    emit(state.copyWith(isTestEnded: true));
  }

  void setSelectedAnswerIndex(int index) {
    List<int?> answersTemp = List<int?>.from(state.answers);
    answersTemp[state.currentQuestionIndex] = index;

    emit(state.copyWith(selectedAnswerIndex: index, answers: answersTemp));
  }
}
