part of 'test_game_selection_cubit.dart';

class TestGameSelectionState extends Equatable {
  List<PersonalityTestModel> personalityTestModels;
  bool isLoading;
  int? selectedIndex;
  TestGameSelectionState(
      {this.personalityTestModels = const [],
      this.isLoading = false,
      this.selectedIndex});

  @override
  List<Object?> get props => [
        personalityTestModels,
        isLoading,
        selectedIndex,
      ];

  TestGameSelectionState copyWith({
    List<PersonalityTestModel>? personalityTestModels,
    bool? isLoading,
    int? selectedIndex,
  }) {
    return TestGameSelectionState(
      personalityTestModels:
          personalityTestModels ?? this.personalityTestModels,
      isLoading: isLoading ?? this.isLoading,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
