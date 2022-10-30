import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Init/Language/locale_keys.g.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/knowledge_test_model.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/View/KnowledgeGame/cubit/knowledge_game_cubit.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';

class KnowledgeGameView extends StatefulWidget {
  KnowledgeTestModel knowledgeTestModel;
  KnowledgeGameView({super.key, required this.knowledgeTestModel});

  @override
  State<KnowledgeGameView> createState() => _KnowledgeGameViewState();
}

class _KnowledgeGameViewState extends State<KnowledgeGameView> {
  late KnowledgeGameCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = KnowledgeGameCubit(knowledgeTestModel: widget.knowledgeTestModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: Column(
            children: [
              BlocBuilder<KnowledgeGameCubit, KnowledgeGameState>(
                bloc: cubit,
                builder: (context, state) {
                  var question = state.knowledgeTestModel
                      .questions![state.currentQuestionIndex];
                  return Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Builder(
                          builder: (context) {
                            if (state.isGameEnded) {
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

  Widget testSummaryWidget(KnowledgeGameState state, BuildContext context) {
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
        child: Column(
          children: [
            CachedNetworkImage(
                imageUrl: state.knowledgeTestModel.quizImage.toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                state.knowledgeTestModel.quizTitle.toString(),
                style:
                    context.textTheme.headline5!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                LocaleKeys.tests_countCorrectAnswers.tr(args: [
                  state.correctAnswerCount.toString(),
                  (10 - state.correctAnswerCount).toString()
                ]),
                style:
                    context.textTheme.headline5!.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                  ),
                  onPressed: () {
                    context.read<AdsProviderCubit>().state.adForTop10?.show();
                    context.read<AdsProviderCubit>().getTop10TransitionAd();
                    Navigator.pop(context);
                  },
                  child: Text(LocaleKeys.general_finish.tr()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    context.read<AdsProviderCubit>().state.adForTop10?.show();
                    context.read<AdsProviderCubit>().getTop10TransitionAd();
                    cubit.resetGame();
                  },
                  child: Text(LocaleKeys.general_playAgain.tr()),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Container testWidget(BuildContext context, KnowledgeGameState state,
      Questions question, KnowledgeGameCubit cubit) {
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
                  "${LocaleKeys.tests_question.tr()} ${state.currentQuestionIndex + 1}/${state.knowledgeTestModel.questions!.length}",
                  style: context.textTheme.subtitle1
                      ?.copyWith(color: Colors.grey.shade200),
                ),
                SizedBox(height: 12),
                Image.network(
                  question.imageUrl.toString(),
                  width: context.width,
                  height: context.height * 0.2,
                  fit: BoxFit.contain,
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
              child: RawScrollbar(
                thumbVisibility: true,
                trackColor: Colors.white,
                radius: Radius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: question.answers!
                          .mapIndexed(
                            ((index, element) => AnswerCard(
                                  context,
                                  question,
                                  index,
                                  onPressed: () {
                                    cubit.setSelectedAnswerIndex(index);
                                  },
                                  isSelected: state.answers[
                                          state.currentQuestionIndex] ==
                                      index,
                                )),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) {
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
                            child: Text(LocaleKeys.general_previous.tr()),
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
                      onPressed:
                          (state.answers[state.currentQuestionIndex] ?? -1) >= 0
                              ? () {
                                  if (state.currentQuestionIndex + 1 ==
                                      state.knowledgeTestModel.questions
                                          ?.length) {
                                    cubit.increaseCurrentQuestionIndex();
                                    cubit.onTestEnd();
                                    return;
                                  }
                                  cubit.increaseCurrentQuestionIndex();
                                }
                              : null,
                      child: Text(
                        state.currentQuestionIndex + 1 ==
                                state.knowledgeTestModel.questions?.length
                            ? LocaleKeys.general_finish.tr()
                            : LocaleKeys.general_next.tr(),
                      ),
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

  Widget AnswerCard(BuildContext context, Questions question, int index,
      {VoidCallback? onPressed, bool isSelected = false}) {
    return Align(
      child: BounceWithoutHover(
        duration: Duration(milliseconds: 100),
        onPressed: onPressed ?? () {},
        child: Container(
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
                  Expanded(
                    child: Text(
                      question.answers![index].answer.toString(),
                      style: context.textTheme.headline6?.copyWith(
                          color: isSelected ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
