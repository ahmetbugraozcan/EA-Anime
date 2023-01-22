import 'package:equatable/equatable.dart';

class WatchAnimeTabsState extends Equatable {
  final int selectedIndex;

  WatchAnimeTabsState({this.selectedIndex = 0});

  WatchAnimeTabsState copyWith({int? selectedIndex}) {
    return WatchAnimeTabsState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [selectedIndex];
}
