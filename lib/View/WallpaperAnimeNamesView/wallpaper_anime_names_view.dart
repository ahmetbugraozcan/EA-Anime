import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Provider/wallpaper/cubit/wallpaper_cubit.dart';
import 'package:flutterglobal/Provider/wallpaperRoot/cubit/wallpaper_root_cubit.dart';
import 'package:flutterglobal/View/WallpaperAnimeNamesView/cubit/wallpaper_anime_names_cubit.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';

class WallpaperAnimeNamesView extends StatelessWidget {
  WallpaperAnimeNamesView({super.key});
  WallpaperAnimeNamesCubit cubit = WallpaperAnimeNamesCubit();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: BlocBuilder<WallpaperCubit, WallpaperState>(
          buildWhen: (previous, current) =>
              previous.isLoading != current.isLoading,
          bloc: context.read<WallpaperCubit>(),
          builder: (context, state) {
            if (state.isLoading)
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            return Center(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return BounceWithoutHover(
                    duration: Duration(milliseconds: 200),
                    onPressed: () {
                      context
                          .read<WallpaperCubit>()
                          .filterWallpapersWithAnimeName(
                            state.animeNames[index].animeName.toString(),
                          );
                      context.read<WallpaperRootCubit>().setPageIndex(1);
                    },
                    child: Container(
                        child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CachedNetworkImage(
                          imageUrl: state.animeNames[index].imageUrl.toString(),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.animeNames[index].animeName.toString(),
                            style: context.textTheme.headline6?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                  );
                },
                itemCount: state.animeNames.length,
              ),
            );
          },
        ),
      ),
    );
  }
}
