part of 'wallpaper_root_cubit.dart';

class WallpaperRootState extends Equatable {
  int pageIndex;

  WallpaperRootState({this.pageIndex = 0});

  List<Widget> pages = [
    WallpaperAnimeNamesView(),
    WallpaperView(),
  ];

  List<Object> get props => [
        pageIndex,
        pages,
      ];

  WallpaperRootState copyWith({
    int? pageIndex,
  }) {
    return WallpaperRootState(
      pageIndex: pageIndex ?? this.pageIndex,
    );
  }
}
