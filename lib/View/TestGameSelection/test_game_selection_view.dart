import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/testgame/cubit/test_game_selection_cubit.dart';
import 'package:flutterglobal/View/TestGame/test_game_view.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';

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
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.personalityTestModels.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(12),
                          child: BounceWithoutHover(
                            duration: Duration(milliseconds: 100),
                            onPressed: () {
                              context
                                  .read<TestGameSelectionCubit>()
                                  .setSelectedIndex(index);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TestGameView()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: [
                                  Image.network(
                                    state.personalityTestModels[index].testImage
                                        .toString(),
                                    height: 200,
                                  ),
                                  Text(state
                                      .personalityTestModels[index].testTitle
                                      .toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
