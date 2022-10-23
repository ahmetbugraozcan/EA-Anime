import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/View/KnowledgeGameList/knowledge_game_list.dart';
import 'package:flutterglobal/View/TestGameSelection/test_game_selection_view.dart';
import 'package:flutterglobal/Widgets/Buttons/back_button.dart';
import 'package:flutterglobal/Widgets/Cards/MenuGuessCard/menu_guess_card.dart';

class TestTypeView extends StatelessWidget {
  const TestTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: Column(
            children: [
              BackButtonWidget(),
              MenuGuessCard(
                fit: BoxFit.fill,
                title: "Kişilik Testleri",
                subtitle:
                    "Kişilik testleri ile hangi anime karakterine benzediğini öğren!",
                background: ImageEnums.animeview,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestGameSelectionView(),
                    ),
                  );
                },
              ),
              MenuGuessCard(
                title: "Bilgi Testleri",
                subtitle: "Bilgi testleri ile anime bilginizi ölçün!",
                background: ImageEnums.itachi,
                isNewBannerVisible: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KnowledgeGameList(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
