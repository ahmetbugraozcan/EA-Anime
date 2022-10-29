import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Init/Language/locale_keys.g.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/language/cubit/language_provider_cubit.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';
import 'package:flutterglobal/Widgets/Buttons/back_button.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButtonWidget(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24),
                child: Text(
                  LocaleKeys.settingsPage_preferences.tr(),
                  style: context.textTheme.headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
              ),
              BounceWithoutHover(
                duration: Duration(milliseconds: 100),
                onPressed: () {
                  showLanguageBottomSheet(context);
                },
                child: Card(
                  color: Colors.black.withOpacity(.3),
                  margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.language,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          LocaleKeys.settingsPage_language.tr(),
                          style: context.textTheme.titleLarge?.copyWith(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        Spacer(),
                        Text(
                          Utils.instance.getLanguageString(context
                              .watch<LanguageProviderCubit>()
                              .state
                              .currentLanguage),
                          style: context.textTheme.titleLarge
                              ?.copyWith(color: Colors.grey.shade300),
                        ),
                        SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey.shade300,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset(
                  Utils.instance.getPNGImage(ImageEnums.turkey),
                  width: 36,
                  height: 36,
                ),
                title: Text("Türkçe"),
                onTap: () async {
                  await context
                      .read<LanguageProviderCubit>()
                      .setLanguage(LanguageEnums.TR);
                  context.setLocale(context
                      .read<LanguageProviderCubit>()
                      .state
                      .currentLocale!);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Image.asset(
                    Utils.instance.getPNGImage(ImageEnums.english),
                    width: 36,
                    height: 36),
                title: Text("English"),
                onTap: () {
                  context
                      .read<LanguageProviderCubit>()
                      .setLanguage(LanguageEnums.EN);
                  context.setLocale(context
                      .read<LanguageProviderCubit>()
                      .state
                      .currentLocale!);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
