part of 'language_provider_cubit.dart';

class LanguageProviderState extends Equatable {
  LanguageManager _languageManager = LanguageManager.instance;
  bool isLoading;

  Locale? currentLocale;
  LanguageEnums? currentLanguage;

  LanguageProviderState({
    this.currentLocale,
    this.currentLanguage,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [currentLocale, currentLanguage, isLoading];

  // copywith

  LanguageProviderState copyWith({
    Locale? currentLocale,
    LanguageEnums? currentLanguage,
    bool? isLoading,
  }) {
    return LanguageProviderState(
      currentLocale: currentLocale ?? this.currentLocale,
      currentLanguage: currentLanguage ?? this.currentLanguage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
