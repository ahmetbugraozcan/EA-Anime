import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/testgame/cubit/test_game_selection_cubit.dart';
import 'package:flutterglobal/View/TestGameSelection/test_game_selection_view.dart';
import 'package:flutterglobal/Widgets/Cards/menu_guess_card.dart';

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
              MenuGuessCard(
                title: "Kişilik Testleri",
                subtitle:
                    "Kişilik testleri ile hangi anime karakterine benzediğini öğren!",
                background: ImageEnums.background,
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
                subtitle:
                    "Çeşitli testlerle anime karakterlerini ve evrenleri tanıyıp tanımadığını öğren. Süre sınırı yok.",
                background: ImageEnums.drstone,
                onPressed: () async {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
