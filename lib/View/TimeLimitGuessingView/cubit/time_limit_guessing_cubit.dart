import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Core/Constants/app_constants.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/guess_card_model.dart';
import 'package:flutterglobal/Models/guessing_model.dart';

part 'time_limit_guessing_state.dart';

class TimeLimitGuessingCubit extends Cubit<TimeLimitGuessingState> {
  late Timer timer;
  TimeLimitGuessingCubit() : super(TimeLimitGuessingState()) {
    state.timeLimit = AppConstants.instance.defaultTimeForGuessingGame;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.timeLimit == 1) {
        emit(state.copyWith(isTimeOut: true, timeLimit: state.timeLimit - 1));
        timer.cancel();
      } else {
        emit(state.copyWith(timeLimit: state.timeLimit - 1));
      }
    });
  }

  disposeTimer() {
    timer.cancel();
  }

  void changeQuestion() {
    changeQuestionIndex(state.questionIndex + 1);
  }

  void restartTimer() {
    timer.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (state.timeLimit == 1) {
        emit(state.copyWith(isTimeOut: true, timeLimit: state.timeLimit - 1));
        timer.cancel();
      } else {
        emit(state.copyWith(timeLimit: state.timeLimit - 1));
      }
    });
  }

  void whenUserWatchedAd() {
    emit(state.copyWith(
        isTimeOut: false,
        timeLimit: AppConstants.instance.extraTimeForGuessingGame,
        isAdShown: true));
  }

  void setTimeLimit(int timeLimit) {
    emit(state.copyWith(timeLimit: timeLimit));
  }

  void setAdShown(bool isAdShown) {
    emit(state.copyWith(isAdShown: isAdShown));
  }

  void setRandomQuestions(List<Questions> randomQuestions) {
    emit(state.copyWith(randomQuestions: randomQuestions));

    List<GuessCardModel?> list = List.filled(
        state.randomQuestions[state.questionIndex].guessingWord?.length ?? 0,
        null);

    emit(state.copyWith(userGuessedWords: list));
    _getShuffeledList();
  }

  void changeQuestionIndex(int index) {
    if (index < (state.randomQuestions.length)) {
      emit(state.copyWith(currentQuestionIndex: index));
      _getShuffeledList();
      _resetGuessingWords();

      changeAnimeTitleVisibility(false);
    }
  }

  void _getShuffeledList() {
    List<String> list = Utils.instance.getShuffeledRandomList(
        state.randomQuestions[state.questionIndex].guessingWord, 14);
    List<GuessCardModel> shuffeledList = List.generate(
        list.length,
        (index) => GuessCardModel(
              id: index,
              isHidden: false,
              guessingWord: list[index],
            ));

    emit(state.copyWith(shuffeledList: shuffeledList));
  }

  void _resetGuessingWords() {
    List<GuessCardModel?> list = List.filled(
        state.randomQuestions[state.questionIndex].guessingWord?.length ?? 0,
        null);

    emit(state.copyWith(userGuessedWords: list));
  }

  void changeAnimeTitleVisibility(bool value) {
    emit(state.copyWith(isAnimeTitleActive: value));
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

  bool _checkAnswer() {
    String answer = "";
    state.userGuessedWords.forEach((element) {
      answer += element!.guessingWord;
    });

    if (answer ==
        state.randomQuestions[state.questionIndex].guessingWord
            ?.toUpperCase()) {
      return true;
    }
    return false;
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

  void unlockImage(Answers images) {
    int? indexOfImage =
        state.randomQuestions[state.questionIndex].answers?.indexOf(images);

    if (indexOfImage != null) {
      state.randomQuestions[state.questionIndex].answers![indexOfImage]
          .isLocked = false;

      emit(state.copyWith(
        randomQuestions: state.randomQuestions,
      ));
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

  void switchPanel() {
    emit(state.copyWith(isPanelActive: !state.isPanelActive));
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
            state.randomQuestions[state.questionIndex].guessingWord?.length) {
          if (_checkAnswer())
            switchPanel();
          else
            resetButtons();
        }
        break;
      }
    }
  }
}
