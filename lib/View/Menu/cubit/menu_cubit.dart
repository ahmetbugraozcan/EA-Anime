import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:meta/meta.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuInitial()) {
    redirect();
  }

  Future<void> redirect() async {
    _changeLoading();
    await Future.delayed(Duration(seconds: 2));
    _setIsLoggedIn(true);
    _changeLoading();
  }

  void _changeLoading() {
    emit(state.copyWith(isLoading: !(state.isLoading)));
  }

  void _setIsLoggedIn(bool value) {
    emit(state.copyWith(isLoggedIn: value));
  }
}
