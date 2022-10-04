import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterglobal/View/WallpaperAnimeNamesView/wallpaper_anime_names_view.dart';
import 'package:flutterglobal/View/WallpaperPage/wallpaper_view.dart';

part 'wallpaper_root_state.dart';

class WallpaperRootCubit extends Cubit<WallpaperRootState> {
  WallpaperRootCubit() : super(WallpaperRootState());

  void setPageIndex(int index) {
    if (index == state.pageIndex) return;
    emit(state.copyWith(pageIndex: index));
  }
}
