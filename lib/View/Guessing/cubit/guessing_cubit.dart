import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/guess_card_model.dart';
import 'package:flutterglobal/Models/guessing_data_model.dart';
import 'package:flutterglobal/Models/guessing_model.dart';
import 'package:flutterglobal/Service/firebase_realtime_db_service.dart';

part 'guessing_state.dart';

class GuessingCubit extends Cubit<GuessingState> {
  FirebaseRealtimeDBService _firebaseRealtimeDBService =
      FirebaseRealtimeDBService.instance;
  GuessingCubit() : super(GuessingState()) {
    getQuestionsFromJson();
  }

  Future<void> getQuestionsFromJson() async {
    _switchLoading();
    _firebaseRealtimeDBService.getDatas();

    List<GuessingModel> questions = [];
    GuessingDataModel? model = await _firebaseRealtimeDBService.getDatas();
    if (model != null) {
      questions = model.guessingModels!;
      List<GuessCardModel?> list = List.filled(
          questions[state.questionIndex].guessingWord?.length ?? 0, null);

      emit(state.copyWith(guessingModels: questions, userGuessedWords: list));
    }

    _getShuffeledList();
    _switchLoading();
  }

  void changeQuestion() {
    changeQuestionIndex(state.questionIndex + 1);
  }

  void addGuessingWord(GuessCardModel cardModel) {
    List<GuessCardModel?> list = List.from(state.userGuessedWords);
    List<GuessCardModel>? shuffle = List.from(state.shuffeledList);
    for (int i = 0; i < list.length; i++) {
      if (list[i] == null) {
        list[i] = cardModel;
        shuffle[shuffle.indexOf(cardModel)].isHidden = true;

        emit(state.copyWith(userGuessedWords: list, shuffeledList: shuffle));

        if (_getGuessedWordsLength() ==
            state.guessingModels[state.questionIndex].guessingWord?.length) {
          if (_checkAnswer())
            switchPanel();
          else
            resetButtons();
        }
        break;
      }
    }
  }

  void removeGuessingWord(GuessCardModel? cardModel) {
    if (cardModel == null) return;
    List<GuessCardModel?> list = List.from(state.userGuessedWords);
    List<GuessCardModel>? shuffle = List.from(state.shuffeledList);
    for (int i = 0; i < list.length; i++) {
      if (list[i] == cardModel) {
        list[i] = null;
        break;
      }
    }

    shuffle[shuffle.indexOf(cardModel)].isHidden = false;
    emit(state.copyWith(userGuessedWords: list, shuffeledList: shuffle));
  }

  void unlockImage(HintImages images) {
    int? indexOfImage =
        state.guessingModels[state.questionIndex].hintImages?.indexOf(images);

    if (indexOfImage != null) {
      state.guessingModels[state.questionIndex].hintImages![indexOfImage]
          .isLocked = false;

      emit(state.copyWith(
        guessingModels: state.guessingModels,
      ));
    }
  }

  Future<void> resetButtons() async {
    state.userGuessedWords.forEach((element) {
      state.shuffeledList[state.shuffeledList.indexOf(element!)].isHidden =
          false;
    });
    state.userGuessedWords = List.filled(state.userGuessedWords.length, null);
    emit(state.copyWith(isAnsweredWrong: true));

    await Future.delayed(Duration(seconds: 1));

    emit(state.copyWith(
      userGuessedWords: state.userGuessedWords,
      shuffeledList: state.shuffeledList,
      isAnsweredWrong: false,
    ));
  }

  void changeAnimeTitleVisibility(bool value) {
    emit(state.copyWith(isAnimeTitleActive: value));
  }

  bool _checkAnswer() {
    String answer = "";
    state.userGuessedWords.forEach((element) {
      answer += element!.guessingWord;
    });

    if (answer ==
        state.guessingModels[state.questionIndex].guessingWord?.toUpperCase()) {
      return true;
    }
    return false;
  }

  int _getGuessedWordsLength() {
    int length = 0;

    state.userGuessedWords.forEach((element) {
      if (element != null) {
        length++;
      }
    });
    return length;
  }

  void _resetGuessingWords() {
    List<GuessCardModel?> list = List.filled(
        state.guessingModels[state.questionIndex].guessingWord?.length ?? 0,
        null);

    emit(state.copyWith(userGuessedWords: list));
  }

  void _getShuffeledList() {
    List<String> list = Utils.instance.getShuffeledRandomList(
        state.guessingModels[state.questionIndex].guessingWord!, 14);
    List<GuessCardModel> shuffeledList = List.generate(
        list.length,
        (index) => GuessCardModel(
              id: index,
              isHidden: false,
              guessingWord: list[index],
            ));

    emit(state.copyWith(shuffeledList: shuffeledList));
  }

  void _switchLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void switchPanel() {
    emit(state.copyWith(isPanelActive: !state.isPanelActive));
  }

  void changeQuestionIndex(int index) {
    if (index < state.guessingModels.length) {
      emit(state.copyWith(questionIndex: index));
      _getShuffeledList();
      _resetGuessingWords();
      changeAnimeTitleVisibility(false);
    }
  }
}
