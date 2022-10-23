import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/knowledge_test_model.dart';
import 'package:flutterglobal/Service/firebase_firestore_service.dart';

part 'knowledge_game_list_state.dart';

class KnowledgeGameListCubit extends Cubit<KnowledgeGameListState> {
  FirebaseFireStoreService _firebaseFireStoreService =
      FirebaseFireStoreService.instance;
  KnowledgeGameListCubit() : super(KnowledgeGameListState()) {
    getKnowledgeGameList();
  }

  Future<void> getKnowledgeGameList() async {
    emit(state.copyWith(isLoading: true));
    var knowledgeGameList =
        await _firebaseFireStoreService.getKnowledgeTestModels();
    emit(
        state.copyWith(isLoading: false, knowledgeGameList: knowledgeGameList));
  }
}
