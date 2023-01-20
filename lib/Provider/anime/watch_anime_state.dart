import 'package:equatable/equatable.dart';

class WatchAnimeState extends Equatable {
  bool isLoading = false;

  WatchAnimeState({this.isLoading = false});

  WatchAnimeState copyWith({bool? isLoading}) {
    return WatchAnimeState(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [isLoading];
}
