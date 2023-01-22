import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Provider/anime/watch_anime_state.dart';
import 'package:flutterglobal/View/WatchAnimeTabs/watch_anime_tabs_cubit/watch_anime_tabs_state.dart';

class WatchAnimeTabsCubit extends Cubit<WatchAnimeTabsState> {
  WatchAnimeTabsCubit() : super(WatchAnimeTabsState());

  void setSelectedTabIndex(int selectedIndex) {
    emit(state.copyWith(selectedIndex: selectedIndex));
  }
}
