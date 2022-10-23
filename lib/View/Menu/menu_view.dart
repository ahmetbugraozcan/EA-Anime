import 'package:flutter/material.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/View/Blogs/blogs_view.dart';
import 'package:flutterglobal/View/Guessing/guessing_view.dart';
import 'package:flutterglobal/View/GuessingGameTypesRoot/guessing_game_types_root.dart';
import 'package:flutterglobal/View/GuessingGamesList/guessing_games_list_view.dart';
import 'package:flutterglobal/View/TestType/test_type_view.dart';
import 'package:flutterglobal/View/WallpaperRootPage/wallpaper_root_view.dart';
import 'package:flutterglobal/Widgets/Cards/MenuGuessCard/menu_guess_card.dart';

class MenuView extends StatefulWidget {
  MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    animation = Tween(begin: 0.0, end: 1200.0).animate(animationController);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height,
        width: context.width,
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  MenuGuessCard(
                    title: "Tahmin Et",
                    subtitle:
                        "Verilen ipuçlarına göre anime karakterlerini tahmin etmeye çalış.",
                    background: ImageEnums.guess,
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GuessingGameTypesRoot()));
                    },
                  ),
                  MenuGuessCard(
                    title: "Testler",
                    subtitle:
                        "Çeşitli testlerle anime karakterlerini tanıyıp tanımadığını öğren. Süre sınırı yok.",
                    background: ImageEnums.drstone,
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestTypeView(),
                        ),
                      );
                    },
                  ),
                  // MenuGuessCard(
                  //   title: "Haberler",
                  //   subtitle:
                  //       "Anime haberlerini takip etmek için haberler bölümüne göz at.",
                  //   background: ImageEnums.drstone,
                  // ),

                  MenuGuessCard(
                    title: "Duvar kağıtları",
                    subtitle:
                        "Birbirinden güzel anime duvar kağıtlarını indir ve telefonunu süsle.",
                    background: ImageEnums.sao,
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WallpaperRootView(),
                        ),
                      );
                    },
                  ),
                  MenuGuessCard(
                    title: "En İyi 10",
                    subtitle:
                        "En iyi 10 anime ve anime karakterlerini görmek için en iyi 10 bölümüne göz at.",
                    background: ImageEnums.naruto,
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogsView(),
                        ),
                      );
                    },
                  ),
                  MenuGuessCard(
                    title: "Stickerlar",
                    subtitle: "ÇOK YAKINDA!",
                    background: ImageEnums.megumin,
                  )
                ],
              ),
            ),
          ),
        ) /* add child content here */,
      ),
    );
  }
}
