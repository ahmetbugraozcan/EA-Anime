import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/personality_test_model.dart';
import 'package:flutterglobal/Provider/testgame/cubit/test_game_selection_cubit.dart';
import 'package:flutterglobal/View/TestGame/cubit/test_game_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';

// test classı değildir test oyunlarının bulunduğu sayfadır
class TestGameView extends StatelessWidget {
  TestGameView({super.key});

  @override
  Widget build(BuildContext context) {
    TestGameCubit cubit = TestGameCubit(
        context.read<TestGameSelectionCubit>().state.personalityTestModels[
            context.read<TestGameSelectionCubit>().state.selectedIndex ?? 0]);

    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: Column(
            children: [
              BlocBuilder<TestGameCubit, TestGameState>(
                bloc: cubit,
                builder: (context, state) {
                  Tests question = state
                      .personalityTestModel!.tests![state.currentQuestionIndex];

                  //            Tests question = state
                  // .personalityTestModels[state.currentTestIndex]
                  // .tests![state.currentQuestionIndex];
                  return Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Builder(
                          builder: (context) {
                            if (state.isTestEnded) {
                              return testSummaryWidget(state, context);
                            } else {
                              return testWidget(
                                  context, state, question, cubit);
                            }
                          },
                        ),
                      ),
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

  Widget testSummaryWidget(TestGameState state, BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            children: [
              Image.network(
                state.personalityTestModel?.characters![0].image ?? "",
                height: 250,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  state.personalityTestModel?.characters![0].name.toString() ??
                      "",
                  style: context.textTheme.headline4
                      ?.copyWith(color: Colors.white),
                ),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.personalityTestModel?.characters![0].description
                            .toString() ??
                        "",
                    style: context.textTheme.subtitle2
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Bitir"),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Container testWidget(BuildContext context, TestGameState state,
      Tests question, TestGameCubit cubit) {
    return Container(
      width: context.width,
      height: context.height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(12),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Soru ${state.currentQuestionIndex + 1}/${state.personalityTestModel!.tests!.length}",
                  style: context.textTheme.subtitle1
                      ?.copyWith(color: Colors.grey.shade200),
                ),
                SizedBox(height: 12),
                Image.network(
                  question.imageUrl.toString(),
                  width: context.width,
                  height: context.height * 0.2,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 12),
                Text(
                  question.question.toString(),
                  style: context.textTheme.subtitle1
                      ?.copyWith(color: Colors.grey.shade200),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: question.answers!
                    .mapIndexed(
                      ((index, element) => Expanded(
                            child: AnswerCard(
                              context,
                              question,
                              index,
                              onPressed: () {
                                cubit.setSelectedAnswerIndex(index);
                              },
                              isSelected:
                                  state.answers[state.currentQuestionIndex] ==
                                      index,
                            ),
                          )),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) {
                      // buna bastığımızda verdiğimiz puanları geri alırız devam ederken geri ekleriz falan filan
                      if (state.currentQuestionIndex > 0) {
                        return SizedBox(
                          width: 120,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.orange,
                            ),
                            onPressed: () {
                              cubit.decreaseCurrentQuestionIndex();
                            },
                            child: Text("Önceki Soru"),
                          ),
                        );
                      }
                      return SizedBox();
                    },
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        if (state.currentQuestionIndex + 1 ==
                            state.personalityTestModel?.tests?.length) {
                          cubit.increaseCurrentQuestionIndex();
                          cubit.onEndTest();
                          return;
                        }
                        cubit.increaseCurrentQuestionIndex();
                      },
                      child: Text(state.currentQuestionIndex + 1 ==
                              state.personalityTestModel?.tests?.length
                          ? "Bitir"
                          : "Sonraki"),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget AnswerCard(BuildContext context, Tests question, int index,
      {VoidCallback? onPressed, bool isSelected = false}) {
    return BounceWithoutHover(
      duration: Duration(milliseconds: 100),
      onPressed: onPressed ?? () {},
      child: Card(
        color: isSelected ? Colors.greenAccent.withOpacity(0.3) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(
            color: isSelected ? Colors.green : Colors.black,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.green,
                shape: CircleBorder(),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: isSelected,
                onChanged: (value) {},
              ),
              Text(
                question.answers![index].answer.toString(),
                style: context.textTheme.headline6
                    ?.copyWith(color: isSelected ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
