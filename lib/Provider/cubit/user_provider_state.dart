part of 'user_provider_cubit.dart';

class UserProviderState extends Equatable {
  UserModel? user;
  bool isLoading;

  UserProviderState({
    this.user,
    this.isLoading = false,
  });

  UserProviderState copyWith({
    UserModel? user,
    bool? isLoading,
  }) {
    return UserProviderState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        user,
        isLoading,
      ];
}
