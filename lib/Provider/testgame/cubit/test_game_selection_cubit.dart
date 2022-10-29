import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/personality_test_model.dart';
import 'package:flutterglobal/Repositories/realtime_db_repository.dart';
import 'package:flutterglobal/Service/FirebaseRealtimeRb/firebase_realtime_db_service.dart';
import 'package:flutterglobal/Service/FirebaseRealtimeRb/i_firebase_realtime_db_service.dart';

part 'test_game_selection_state.dart';

class TestGameSelectionCubit extends Cubit<TestGameSelectionState> {
  RealtimeDBRepository repository = RealtimeDBRepository.instance;

  TestGameSelectionCubit() : super(TestGameSelectionState()) {
    getQuestionsFromJson();
  }

  Future<void> getQuestionsFromJson() async {
    _switchLoading();

    List<PersonalityTestModel>? model =
        await repository.getPersonalityQuestionsData();
    print(model);
    if (model != null) {
      emit(state.copyWith(personalityTestModels: List.from(model)));
    }

    _switchLoading();
  }

  void _switchLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void setSelectedIndex(int selectedIndex) {
    emit(state.copyWith(selectedIndex: selectedIndex));
  }
}
