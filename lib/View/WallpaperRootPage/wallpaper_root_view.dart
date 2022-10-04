import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/wallpaper/cubit/wallpaper_cubit.dart';
import 'package:flutterglobal/Provider/wallpaperRoot/cubit/wallpaper_root_cubit.dart';

class WallpaperRootView extends StatelessWidget {
  WallpaperRootView({super.key});
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      drawer: BlocBuilder<WallpaperRootCubit, WallpaperRootState>(
        bloc: context.read<WallpaperRootCubit>(),
        buildWhen: (previous, current) =>
            previous.pageIndex != current.pageIndex,
        builder: (context, state) {
          return buildWallpapersDrawer(state, context);
        },
      ),
      body: BlocBuilder<WallpaperRootCubit, WallpaperRootState>(
        bloc: context.read<WallpaperRootCubit>(),
        buildWhen: (previous, current) =>
            previous.pageIndex != current.pageIndex,
        builder: (context, state) {
          return Container(
            decoration:
                Utils.instance.backgroundDecoration(ImageEnums.background),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          globalKey.currentState?.openDrawer();
                        },
                        icon: Icon(Icons.menu),
                        color: Colors.white,
                      ),
                      Builder(builder: (ctx) {
                        if (state.pageIndex == 1) {
                          return IconButton(
                            onPressed: () {
                              context.read<WallpaperCubit>().switchGridState();
                            },
                            icon: Icon(Icons.calendar_view_week),
                            color: Colors.white,
                          );
                        }
                        return SizedBox();
                      })
                    ],
                  ),
                  state.pages[state.pageIndex],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Drawer buildWallpapersDrawer(WallpaperRootState state, BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color:
                  state.pageIndex == 0 ? Colors.grey[300] : Colors.transparent,
              child: ListTile(
                onTap: () {
                  globalKey.currentState?.closeDrawer();
                  context.read<WallpaperRootCubit>().setPageIndex(0);
                },
                title: Text(
                  "Animeye Göre",
                ),
                subtitle: Text("Animeye Göre"),
              ),
            ),
            Container(
              color:
                  state.pageIndex == 1 ? Colors.grey[300] : Colors.transparent,
              child: ListTile(
                onTap: () {
                  globalKey.currentState?.closeDrawer();

                  context.read<WallpaperRootCubit>().setPageIndex(1);
                },
                title: Text(
                  "Keşfet",
                ),
                subtitle: Text("Keşfet"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
