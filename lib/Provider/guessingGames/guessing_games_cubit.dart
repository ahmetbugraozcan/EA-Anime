import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/guessing_model.dart';
import 'package:flutterglobal/Repositories/firebase_firestore_repository.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/firebase_firestore_service.dart';
import 'package:flutterglobal/Service/FirebaseFirestore/i_firebase_firestore.dart';

part 'guessing_games_state.dart';

class GuessingGamesCubit extends Cubit<GuessingGamesState> {
  IFirebaseFirestoreService _firebaseFireStoreService =
      FirebaseFirestoreRepository.instance;

  GuessingGamesCubit() : super(GuessingGamesState()) {
    getGuessingGames();
  }

  Future<void> getGuessingGames() async {
    switchLoading();
    List<GuessingModel>? guessingGames =
        await _firebaseFireStoreService.getGuessingGameData();
    if (guessingGames != null) {
      emit(state.copyWith(guessingGames: guessingGames));
    }
    switchLoading();
  }

  void switchLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void setGuessingGames(List<GuessingModel> guessingGames) {
    emit(state.copyWith(guessingGames: guessingGames));
  }
}
