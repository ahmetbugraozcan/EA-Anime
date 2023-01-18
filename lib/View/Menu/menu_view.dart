import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Init/Language/locale_keys.g.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Provider/language/cubit/language_provider_cubit.dart';
import 'package:flutterglobal/View/Blogs/blogs_view.dart';
import 'package:flutterglobal/View/GuessingGameTypesRoot/guessing_game_types_root.dart';
import 'package:flutterglobal/View/Settings/settings_view.dart';
import 'package:flutterglobal/View/Stickers/stickers_view.dart';
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
        child: RawScrollbar(
          thumbVisibility: true,
          trackColor: Colors.white,
          radius: Radius.circular(10),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    MenuGuessCard(
                      title: LocaleKeys.menuPage_guessTitle.tr(),
                      subtitle: LocaleKeys.menuPage_guessSubtitle.tr(),
                      background: ImageEnums.guess,
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GuessingGameTypesRoot(),
                            settings:
                                RouteSettings(name: "GuessingGameTypesRoot"),
                          ),
                        );
                      },
                    ),
                    MenuGuessCard(
                      title: LocaleKeys.menuPage_tests.tr(),
                      subtitle: LocaleKeys.menuPage_testsSubtitle.tr(),
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
                      title: LocaleKeys.menuPage_wallpapers.tr(),
                      subtitle: LocaleKeys.menuPage_wallpapersSubtitle.tr(),
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
                      title: LocaleKeys.menuPage_top10.tr(),
                      subtitle: LocaleKeys.menuPage_top10Subtitle.tr(),
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
                      title: LocaleKeys.menuPage_stickers.tr(),
                      subtitle: LocaleKeys.menuPage_stickersSubtitle.tr(),
                      background: ImageEnums.megumin,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StickersView(),
                          ),
                        );
                      },
                    ),
                    MenuGuessCard(
                      title: LocaleKeys.menuPage_settings.tr(),
                      subtitle: LocaleKeys.menuPage_settingsSubtitle.tr(),
                      background: ImageEnums.datealive,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsView(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ) /* add child content here */,
      ),
    );
  }
}
