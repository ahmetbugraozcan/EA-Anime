part of 'guessing_games_cubit.dart';

class GuessingGamesState extends Equatable {
  bool isLoading;
  List<GuessingModel>? guessingGames;

  GuessingGamesState({
    this.isLoading = false,
    this.guessingGames = const [],
  });

  GuessingGamesState copyWith({
    bool? isLoading,
    List<GuessingModel>? guessingGames,
  }) {
    return GuessingGamesState(
      isLoading: isLoading ?? this.isLoading,
      guessingGames: guessingGames ?? this.guessingGames,
    );
  }

  List<Object?> get props => [
        isLoading,
        guessingGames,
      ];
}
