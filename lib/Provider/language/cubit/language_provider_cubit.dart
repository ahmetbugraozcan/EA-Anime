import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Init/Cache/locale_manager.dart';
import 'package:flutterglobal/Core/Init/Language/language_manager.dart';

part 'language_provider_state.dart';

class LanguageProviderCubit extends Cubit<LanguageProviderState> {
  CacheManager _cacheManager = CacheManager.instance;
  LanguageProviderCubit() : super(LanguageProviderState()) {
    getLanguage();
  }

  Future<void> getLanguage() async {
    _switchLoading();
    String language = _cacheManager.getStringValue(PreferencesKeys.LANGUAGE);
    print("FIRST LANGUAGE :$language");
    if (language.isNotEmpty) {
      await setLanguage(
        LanguageEnums.values
                .firstWhereOrNull((element) => element.name == language) ??
            LanguageEnums.EN,
      );
    } else {
      await setLanguage(LanguageEnums.EN);
    }
    await Future.delayed(Duration(milliseconds: 0));

    _switchLoading();
  }

  Future<void> setLanguage(LanguageEnums language) async {
    emit(
      state.copyWith(
        currentLanguage: language,
        currentLocale: LanguageManager.instance.getLocale(language),
      ),
    );
    await _cacheManager.setStringValue(PreferencesKeys.LANGUAGE, language.name);
  }

  void _switchLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }
}
