import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Constants/app_constants.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/View/Guessing/guessing_view.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';
import 'package:flutterglobal/Widgets/Cards/menu_guess_card.dart';
import 'package:google_fonts/google_fonts.dart';

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
    // TODO: implement initState
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
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(animation.value, 0),
                        child: MenuGuessCard(
                          title: "Tahmin Et",
                          subtitle:
                              "Verilen ipuçlarına göre anime karakterlerini tahmin etmeye çalış. Süre sınırı yok.",
                          background: ImageEnums.guess,
                          onPressed: () async {
                            await animationController.forward();

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => GuessingView(),
                              ),
                            );

                            /* Bu delayı eklemediğimizde sayfa geçişinden önce buton eski yerine tekrar dönüyor
                            ve bu durum kullanıcıya yansıyor bundan dolayı delayi ekledik */
                            await Future.delayed(Duration(milliseconds: 100));
                            animationController.reset();
                          },
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
                  // MenuGuessCard(
                  //   title: "Kişilik Testleri",
                  //   subtitle:
                  //       "Hangi anime karakterine benzediğini öğrenmek için kişilik testlerine göz at.",
                  //   background: ImageEnums.itachi,
                  // ),
                  // MenuGuessCard(
                  //   title: "Duvar kağıtları",
                  //   subtitle:
                  //       "Birbirinden güzel anime duvar kağıtlarını indir ve telefonunu süsle.",
                  //   background: ImageEnums.sao,
                  // ),
                  // MenuGuessCard(
                  //   title: "Duvar kağıtları",
                  //   subtitle:
                  //       "Birbirinden güzel anime duvar kağıtlarını indir ve telefonunu süsle.",
                  //   background: ImageEnums.sao,
                  // )
                ],
              ),
            ),
          ),
        ) /* add child content here */,
      ),
    );
  }
}
