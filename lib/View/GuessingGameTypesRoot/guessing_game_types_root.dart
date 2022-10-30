import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Init/Language/locale_keys.g.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/cubit/user_provider_cubit.dart';
import 'package:flutterglobal/Provider/guessingGames/guessing_games_cubit.dart';
import 'package:flutterglobal/View/GuessingGamesList/guessing_games_list_view.dart';
import 'package:flutterglobal/View/TimeLimitGuessingView/time_limit_guessing_view.dart';
import 'package:flutterglobal/Widgets/Buttons/back_button.dart';
import 'package:flutterglobal/Widgets/Cards/MenuGuessCard/menu_guess_card.dart';

class GuessingGameTypesRoot extends StatelessWidget {
  const GuessingGameTypesRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height,
        width: context.width,
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: Column(
            children: [
              BackButtonWidget(),
              BlocBuilder<GuessingGamesCubit, GuessingGamesState>(
                bloc: context.read<GuessingGamesCubit>(),
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                    );
                  }
                  return Column(
                    children: [
                      MenuGuessCard(
                        title:
                            LocaleKeys.guessingGameTypesRootPage_byAnime.tr(),
                        subtitle: LocaleKeys
                            .guessingGameTypesRootPage_byAnimeSubtitle
                            .tr(),
                        background: ImageEnums.blackgoku,
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GuessingGamesListView(),
                              settings:
                                  RouteSettings(name: "GuessingGamesList"),
                            ),
                          );
                        },
                      ),
                      Stack(
                        children: [
                          MenuGuessCard(
                            title: LocaleKeys
                                .guessingGameTypesRootPage_timeLimitMixed
                                .tr(),
                            bottomCenterText: LocaleKeys
                                .guessingGameTypesRootPage_timeLimitHighScore
                                .tr(args: [
                              (context
                                          .watch<UserProviderCubit>()
                                          .state
                                          .user
                                          ?.timelimitHighScore ??
                                      0)
                                  .toString()
                            ]),
                            isNewBannerVisible: true,
                            subtitle: LocaleKeys
                                .guessingGameTypesRootPage_timeLimitMixedSubtitle
                                .tr(),
                            background: ImageEnums.randomAnimes,
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TimeLimitGuessingView(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
