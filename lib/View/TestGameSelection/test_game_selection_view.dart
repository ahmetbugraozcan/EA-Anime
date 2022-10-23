import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/Provider/testgame/cubit/test_game_selection_cubit.dart';
import 'package:flutterglobal/View/TestGame/test_game_view.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';
import 'package:flutterglobal/Widgets/Buttons/back_button.dart';
import 'package:flutterglobal/Widgets/Cards/StackedTextCard/stacked_text_card.dart';

class TestGameSelectionView extends StatelessWidget {
  const TestGameSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: Column(
            children: [
              BackButtonWidget(),
              BlocBuilder<TestGameSelectionCubit, TestGameSelectionState>(
                bloc: context.read<TestGameSelectionCubit>(),
                builder: (context, state) {
                  if (state.isLoading) {
                    return Expanded(
                      child: Center(
                          child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      )),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: state.personalityTestModels.length,
                      itemBuilder: (context, index) {
                        return StackedTextCard(
                          imageUrl: state.personalityTestModels[index].testImage
                              .toString(),
                          onPressed: () {
                            context
                                .read<TestGameSelectionCubit>()
                                .setSelectedIndex(index);
                            // REKLAM İŞLEMLERİ
                            context
                                .read<AdsProviderCubit>()
                                .state
                                .adForTop10
                                ?.show();
                            context
                                .read<AdsProviderCubit>()
                                .getTop10TransitionAd();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TestGameView(),
                              ),
                            );
                          },
                          text: state.personalityTestModels[index].testTitle
                              .toString(),
                        );
                      },
                    ),
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
