import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/guess_card_model.dart';
import 'package:flutterglobal/Models/guessing_model.dart';

part 'guessing_state.dart';

class GuessingCubit extends Cubit<GuessingState> {
  GuessingCubit() : super(GuessingState());

  void changeQuestion() {
    changeQuestionIndex(state.questionIndex + 1);
  }

  void setGuessingModel(GuessingModel guessingModel) {
    emit(state.copyWith(guessingModel: guessingModel));
    List<GuessCardModel?> list = List.filled(
        state.guessingModel?.questions?[state.questionIndex].guessingWord
                ?.length ??
            0,
        null);

    emit(state.copyWith(userGuessedWords: list));
    _getShuffeledList();
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
            state.guessingModel?.questions?[state.questionIndex].guessingWord
                ?.length) {
          if (_checkAnswer())
            switchPanel();
          else
            resetButtons();
        }
        break;
      }
    }
  }

  setQuestionIndex(int index) {
    emit(state.copyWith(questionIndex: index));
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

  void unlockImage(Answers images) {
    int? indexOfImage = state
        .guessingModel?.questions?[state.questionIndex].answers
        ?.indexOf(images);

    if (indexOfImage != null) {
      state.guessingModel?.questions?[state.questionIndex]
          .answers![indexOfImage].isLocked = false;

      emit(state.copyWith(
        guessingModel: state.guessingModel,
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
        state.guessingModel?.questions?[state.questionIndex].guessingWord
            ?.toUpperCase()) {
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
        state.guessingModel?.questions?[state.questionIndex].guessingWord
                ?.length ??
            0,
        null);

    emit(state.copyWith(userGuessedWords: list));
  }

  void _getShuffeledList() {
    List<String> list = Utils.instance.getShuffeledRandomList(
        state.guessingModel?.questions?[state.questionIndex].guessingWord, 14);
    List<GuessCardModel> shuffeledList = List.generate(
        list.length,
        (index) => GuessCardModel(
              id: index,
              isHidden: false,
              guessingWord: list[index],
            ));

    emit(state.copyWith(shuffeledList: shuffeledList));
  }

  void switchPanel() {
    emit(state.copyWith(isPanelActive: !state.isPanelActive));
  }

  void changeQuestionIndex(int index) {
    if (index < (state.guessingModel?.questions?.length ?? 0)) {
      emit(state.copyWith(questionIndex: index));
      _getShuffeledList();
      _resetGuessingWords();

      changeAnimeTitleVisibility(false);
    }
  }
}
