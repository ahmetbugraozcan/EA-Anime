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

class TestGameSelectionView extends StatelessWidget {
  const TestGameSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SizedBox.expand(
          child: BlocBuilder<TestGameSelectionCubit, TestGameSelectionState>(
            bloc: context.read<TestGameSelectionCubit>(),
            builder: (context, state) {
              if (state.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return SafeArea(
                child: Column(
                  children: [
                    BackButtonWidget(),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: state.personalityTestModels.length,
                        itemBuilder: (context, index) {
                          return BounceWithoutHover(
                            duration: Duration(milliseconds: 100),
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
                            child: Container(
                              height: 200,
                              alignment: Alignment.bottomLeft,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    state.personalityTestModels[index].testImage
                                        .toString(),
                                  ),
                                ),
                              ),
                              child: Container(
                                width: double.infinity,
                                color: Colors.black.withOpacity(0.5),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    state.personalityTestModels[index].testTitle
                                        .toString(),
                                    style:
                                        context.textTheme.headline6?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // child: Column(
                            //   children: [
                            //     Image.network(
                            //       state.personalityTestModels[index].testImage
                            //           .toString(),
                            //       height: 200,
                            //     ),
                            //     Text(state.personalityTestModels[index].testTitle
                            //         .toString()),
                            //   ],
                            // ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
