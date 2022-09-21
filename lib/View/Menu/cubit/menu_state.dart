part of 'menu_cubit.dart';

@immutable
abstract class MenuState extends Equatable {
  bool isLoading;
  bool isLoggedIn;

  MenuState({this.isLoading = false, this.isLoggedIn = false});

  MenuState copyWith({bool? isLoading, bool? isLoggedIn});
}

class MenuInitial extends MenuState {
  MenuInitial({super.isLoading, super.isLoggedIn});

  @override
  MenuState copyWith({bool? isLoading, bool? isLoggedIn}) {
    return MenuInitial(
      isLoading: isLoading ?? super.isLoading,
      isLoggedIn: isLoggedIn ?? super.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [isLoading, isLoggedIn];
}
