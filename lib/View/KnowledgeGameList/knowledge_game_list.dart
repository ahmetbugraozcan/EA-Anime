import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/View/KnowledgeGame/knowledge_game_view.dart';
import 'package:flutterglobal/View/KnowledgeGameList/cubit/knowledge_game_list_cubit.dart';
import 'package:flutterglobal/Widgets/Buttons/back_button.dart';
import 'package:flutterglobal/Widgets/Cards/StackedTextCard/stacked_text_card.dart';

class KnowledgeGameList extends StatelessWidget {
  KnowledgeGameList({super.key});
  var cubit = KnowledgeGameListCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: Column(
            children: [
              BackButtonWidget(),
              BlocBuilder<KnowledgeGameListCubit, KnowledgeGameListState>(
                bloc: cubit,
                buildWhen: (previous, current) =>
                    previous.isLoading != current.isLoading &&
                    previous.knowledgeGameList != current.knowledgeGameList,
                builder: (context, state) {
                  if (state.isLoading) {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      // itemCount: state.knowledgeGameList.length,
                      itemCount: state.knowledgeGameList.length,
                      itemBuilder: (context, index) => StackedTextCard(
                        text: state.knowledgeGameList[index].quizTitle,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KnowledgeGameView(
                                knowledgeTestModel:
                                    state.knowledgeGameList[index],
                              ),
                            ),
                          );
                        },
                        imageUrl:
                            state.knowledgeGameList[index].quizImage.toString(),
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
}
