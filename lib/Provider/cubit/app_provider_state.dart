part of 'app_provider_cubit.dart';

class AppProviderState extends Equatable {
  UserModel? user;
  bool isLoading;
  AppProviderState({
    this.user,
    this.isLoading = false,
  });

  AppProviderState copyWith({
    UserModel? user,
    bool? isLoading,
  }) {
    return AppProviderState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [user, isLoading];
}
