part of 'knowledge_game_list_cubit.dart';

class KnowledgeGameListState extends Equatable {
  bool isLoading;
  List<KnowledgeTestModel> knowledgeGameList;

  KnowledgeGameListState({
    this.isLoading = false,
    this.knowledgeGameList = const [],
  });

  @override
  List<Object?> get props => [isLoading, knowledgeGameList];

  KnowledgeGameListState copyWith({
    bool? isLoading,
    List<KnowledgeTestModel>? knowledgeGameList,
  }) {
    return KnowledgeGameListState(
      isLoading: isLoading ?? this.isLoading,
      knowledgeGameList: knowledgeGameList ?? this.knowledgeGameList,
    );
  }
}
