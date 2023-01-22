import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/View/WatchAnime/watch_anime_view.dart';
import 'package:flutterglobal/View/WatchAnimeTabs/watch_anime_tabs_cubit/watch_anime_tabs_state.dart';

import 'watch_anime_tabs_cubit/watch_anime_tabs_cubit.dart';

class WatchAnimeTabs extends StatelessWidget {
  WatchAnimeTabs({super.key});
  var cubit = WatchAnimeTabsCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchAnimeTabsCubit, WatchAnimeTabsState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: NavigationBar(
                selectedIndex: state.selectedIndex,
                onDestinationSelected: (value) =>
                    cubit.setSelectedTabIndex(value),
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                ]),
            body: [
              WatchAnimeView(),
              const Center(
                child: Text(
                  'Relearn 👨‍🏫',
                ),
              ),
              const Center(
                child: Text(
                  'Unlearn 🐛',
                ),
              ),
            ][state.selectedIndex]);
      },
    );
  }
}
