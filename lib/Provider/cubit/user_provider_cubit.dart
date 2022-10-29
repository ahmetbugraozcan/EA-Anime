import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Constants/app_constants.dart';
import 'package:flutterglobal/Core/Init/Cache/locale_manager.dart';
import 'package:flutterglobal/Models/level_model.dart';
import 'package:flutterglobal/Models/user_model.dart';
import 'package:collection/collection.dart';

part 'user_provider_state.dart';

class UserProviderCubit extends Cubit<UserProviderState> {
  CacheManager _cacheManager = CacheManager.instance;
  UserProviderCubit() : super(UserProviderState()) {
    _getUser();
  }

  Future<void> _getUser() async {
    _switchLoading();
    String userModel = _cacheManager.getStringValue(PreferencesKeys.USERMODEL);
    if (userModel.isNotEmpty) {
      await setUser(UserModel.fromJson(
        jsonDecode(userModel),
      ));
    } else {
      await setUser(UserModel());
    }
    await Future.delayed(Duration(milliseconds: 0));

    _switchLoading();
  }

  Future<void> buyKey() async {
    UserModel? userModel = state.user?.copyWith(
        keyCount: state.user!.keyCount + 1,
        goldCount: state.user!.goldCount - AppConstants.instance.keyPrice);

    await setUser(userModel);
  }

  Future<void> decrementKey(int keyCount) async {
    log("decrementKey user key count ${state.user?.keyCount ?? "null"}");
    UserModel? userModel =
        state.user?.copyWith(keyCount: (state.user?.keyCount ?? 0) - keyCount);

    await setUser(userModel);

    // UserModel? userModel =
    //     state.user?.copyWith(keyCount: state.user!.keyCount - keyCount);
    // await _cacheManager.setIntValue(
    //     PreferencesKeys.KEY_COUNT, userModel?.keyCount ?? 0);
    // emit(state.copyWith(user: userModel));
  }

  Future<void> addGold(int goldCount) async {
    UserModel? userModel =
        state.user?.copyWith(goldCount: state.user!.goldCount + goldCount);

    await setUser(userModel);

    // UserModel? userModel =
    //     state.user?.copyWith(goldCount: state.user!.goldCount + goldCount);
    // await _cacheManager.setIntValue(
    //     PreferencesKeys.GOLD_COUNT, userModel?.goldCount ?? 0);
    // emit(state.copyWith(user: userModel));
  }

  Future<void> decrementGold(int goldCount) async {
    UserModel? userModel =
        state.user?.copyWith(goldCount: state.user!.goldCount - goldCount);

    await setUser(userModel);

    // UserModel? userModel =
    //     state.user?.copyWith(goldCount: state.user!.goldCount - goldCount);
    // await _cacheManager.setIntValue(
    //     PreferencesKeys.GOLD_COUNT, userModel?.goldCount ?? 0);
    // emit(state.copyWith(user: userModel));
  }

  Future<void> updateLevelValue(String id, int value) async {
    List<Level>? levels = List.from(state.user?.levels ?? []);
    if (levels.firstWhereOrNull((element) => element.levelId == id) != null) {
      if (levels.isNotEmpty) {
        for (var i = 0; i < levels.length; i++) {
          if (levels[i].levelId == id) {
            levels[i].questionIndex = value;
            break;
          }
        }
        await setUser(state.user?.copyWith(levels: levels));
      }
    } else {
      Level level = Level(levelId: id, questionIndex: value);
      levels.add(level);
      await setUser(state.user?.copyWith(levels: levels));
    }
  }

  Future<void> setUser(UserModel? user) async {
    emit(state.copyWith(user: user));
    await _cacheManager.setStringValue(
        PreferencesKeys.USERMODEL, jsonEncode(user));
  }

  void _switchLoading() {
    bool isLoading = !state.isLoading;
    emit(state.copyWith(isLoading: isLoading));
  }
}
