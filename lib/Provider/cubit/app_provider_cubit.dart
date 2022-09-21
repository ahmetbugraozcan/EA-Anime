import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Init/Cache/locale_manager.dart';
import 'package:flutterglobal/Models/user_model.dart';

part 'app_provider_state.dart';

class AppProviderCubit extends Cubit<AppProviderState> {
  CacheManager _cacheManager = CacheManager.instance;
  AppProviderCubit() : super(AppProviderState()) {
    _getUser();
  }

  Future<void> _getUser() async {
    _switchLoading();
    int keyCount = _cacheManager.getIntValue(PreferencesKeys.KEY_COUNT);
    int diamondCount = _cacheManager.getIntValue(PreferencesKeys.DIAMOND_COUNT);
    int goldCount = _cacheManager.getIntValue(PreferencesKeys.GOLD_COUNT);
    UserModel user = UserModel(
        keyCount: keyCount, diamondCount: diamondCount, goldCount: goldCount);

    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(user: user));
    print("usermodel : key ${keyCount}, diamond ${diamondCount}");
    _switchLoading();
  }

  Future<void> buyKey() async {
    UserModel? userModel = state.user?.copyWith(
        keyCount: state.user!.keyCount + 1,
        goldCount: state.user!.goldCount - 250);
    await _cacheManager.setIntValue(
        PreferencesKeys.KEY_COUNT, userModel?.keyCount ?? 0);
    emit(state.copyWith(user: userModel));
  }

  Future<void> decrementKey() async {
    UserModel? userModel =
        state.user?.copyWith(keyCount: state.user!.keyCount - 1);
    await _cacheManager.setIntValue(
        PreferencesKeys.KEY_COUNT, userModel?.keyCount ?? 0);
    emit(state.copyWith(user: userModel));
  }

  Future<void> addGold(int goldCount) async {
    UserModel? userModel =
        state.user?.copyWith(goldCount: state.user!.goldCount + goldCount);
    await _cacheManager.setIntValue(
        PreferencesKeys.GOLD_COUNT, userModel?.goldCount ?? 0);
    emit(state.copyWith(user: userModel));
  }

  Future<void> decrementGold(int goldCount) async {
    UserModel? userModel =
        state.user?.copyWith(goldCount: state.user!.goldCount - goldCount);
    await _cacheManager.setIntValue(
        PreferencesKeys.GOLD_COUNT, userModel?.goldCount ?? 0);
    emit(state.copyWith(user: userModel));
  }

  void _switchLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }
}
