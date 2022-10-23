import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Constants/app_constants.dart';
import 'package:flutterglobal/Core/Extensions/context_extensions.dart';
import 'package:flutterglobal/Core/Utils/utils.dart';
import 'package:flutterglobal/Models/guess_card_model.dart';
import 'package:flutterglobal/Models/guessing_model.dart';
import 'package:flutterglobal/Provider/ads/cubit/ads_provider_cubit.dart';
import 'package:flutterglobal/Provider/cubit/app_provider_cubit.dart';
import 'package:flutterglobal/Provider/guessingGames/guessing_games_cubit.dart';
import 'package:flutterglobal/Provider/network/cubit/network_provider_cubit.dart';
import 'package:flutterglobal/View/Shop/shop_view.dart';
import 'package:flutterglobal/View/TimeLimitGuessingView/cubit/time_limit_guessing_cubit.dart';
import 'package:flutterglobal/Widgets/Bounce/bounce_without_hover.dart';
import 'package:flutterglobal/Widgets/Dialog/dialog_color.scheme.dart';
import 'package:flutterglobal/Widgets/Dialog/dialog_with_background.dart';
import 'package:flutterglobal/Widgets/Game/user_assets_info.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

class TimeLimitGuessingView extends StatefulWidget {
  const TimeLimitGuessingView({super.key});

  @override
  State<TimeLimitGuessingView> createState() => _TimeLimitGuessingViewState();
}

class _TimeLimitGuessingViewState extends State<TimeLimitGuessingView> {
  var cubit = TimeLimitGuessingCubit();
  @override
  void initState() {
    super.initState();
    List<Questions> tempArray = [];
    context.read<GuessingGamesCubit>().state.guessingGames?.forEach(
        (e) => e.questions?.forEach((element) => tempArray.add(element)));
    cubit.setRandomQuestions(tempArray..shuffle());
  }

  @override
  void dispose() {
    cubit.disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: context.height,
        width: context.width,
        decoration: Utils.instance.backgroundDecoration(ImageEnums.background),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocConsumer<TimeLimitGuessingCubit,
                    TimeLimitGuessingState>(
                  buildWhen: (previous, current) {
                    return previous.shuffeledList != current.shuffeledList ||
                        previous.userGuessedWords != current.userGuessedWords ||
                        previous.questionIndex != current.questionIndex ||
                        previous.isTimeOut != current.isTimeOut ||
                        previous.isAnimeTitleActive !=
                            current.isAnimeTitleActive ||
                        previous.randomQuestions != current.randomQuestions ||
                        previous.isPanelActive != current.isPanelActive;
                  },
                  listener: (context, state) {
                    if (state.isTimeOut && state.isAdShown) {
                      cubit.timer.cancel();

                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return WillPopScope(
                            onWillPop: () async => false,
                            child: DialogWithBackground(
                              dialogType: DialogEnums.ERROR,
                              title: "Süre doldu.",
                              contentText:
                                  "Süreniz dolduğu için oyunu kaybettiniz.",
                              onConfirm: () {
                                Navigator.popUntil(
                                  context,
                                  ModalRoute.withName("GuessingGamesList"),
                                );
                              },
                            ),
                          );
                        },
                      );
                    } else if (state.isTimeOut && !state.isAdShown) {
                      cubit.timer.cancel();
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return WillPopScope(
                            onWillPop: () async => false,
                            child: DialogWithBackground(
                              dialogType: DialogEnums.INTERACTIVE,
                              title: "Süre doldu.",
                              confirmText: context
                                      .watch<AdsProviderCubit>()
                                      .state
                                      .isAdLoading
                                  ? "Yükleniyor"
                                  : "İzle",
                              contentText:
                                  "Süreniz dolduğu için oyunu kaybettiniz. Reklam izleyerek ${AppConstants.instance.extraTimeForGuessingGameFromAd} saniye kazanabilirsiniz.",
                              onCancel: () {
                                Navigator.popUntil(
                                  context,
                                  ModalRoute.withName("GuessingGamesList"),
                                );
                              },
                              onConfirm: () async {
                                print("onConfirm");
                                await context
                                    .read<AdsProviderCubit>()
                                    .getInitialRewardAd();

                                var ad =
                                    context.read<AdsProviderCubit>().state.ad;

                                await ad?.show(
                                  onUserEarnedReward:
                                      (rewardedAd, reward) async {
                                    print("onAdUserEarnedReward TRIGGERED");
                                    cubit.whenUserWatchedAd();
                                    await Future.delayed(Duration.zero);
                                    ad.fullScreenContentCallback =
                                        FullScreenContentCallback(
                                      onAdImpression: (ad) {
                                        print("onAdImpression");
                                      },
                                      onAdShowedFullScreenContent: (ad) {
                                        print("onAdShowedFullScreenContent");
                                      },
                                      onAdDismissedFullScreenContent:
                                          (ad) async {
                                        Navigator.pop(context);
                                        cubit.restartTimer();
                                      },
                                      onAdFailedToShowFullScreenContent:
                                          (ad, error) {
                                        print(
                                            "onAdFailedToShowFullScreenContent");
                                      },
                                    );
                                  },
                                );

                                // reklam izle eğer reklam izlediyse süreyi 30 saniye arttır ve oyuna devam ettir iptal eder ise 2 kere nav.pop yap
                              },
                            ),
                          );
                        },
                      );
                    }
                    if (state.isAnsweredWrong) {
                      context.showSnackbar(
                        title: "Yanlış Cevap",
                        subtitle: "Tekrar Deneyin",
                        icon: Icon(Icons.close, color: Colors.red),
                        borderColor: Colors.red,
                      );
                    }
                  },
                  bloc: cubit,
                  builder: (context, state) {
                    if (context
                            .watch<NetworkProviderCubit>()
                            .state
                            .networkStatus ==
                        NetworkStatus.OFFLINE) {
                      return NoInternetWidget(context);
                    }
                    return Stack(
                      children: [
                        Column(
                          children: [
                            Spacer(),
                            UserAssetsInfo(
                              centerWidget: BlocBuilder<TimeLimitGuessingCubit,
                                  TimeLimitGuessingState>(
                                bloc: cubit,
                                buildWhen: (previous, current) =>
                                    previous.timeLimit != current.timeLimit,
                                builder: (context, state) {
                                  return Text(
                                    state.timeLimit.toString(),
                                    style: context.textTheme.headlineMedium
                                        ?.copyWith(color: Colors.white),
                                  );
                                },
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 2,
                              child: userButtonsRow(context, state),
                            ),
                            Expanded(
                              flex: 10,
                              child: hintImagesGrid(state, context),
                            ),
                            Expanded(
                              flex: 3,
                              child: guessedWordsRow(context, state),
                            ),
                            Expanded(
                              flex: 5,
                              child: guessingWordsRow(state, context),
                            ),
                            Spacer(
                              flex: 2,
                            ),
                          ],
                        ),
                        state.isPanelActive
                            ? successPanel(state, context)
                            : SizedBox(),
                      ],
                    );
                  },
                ),
              ),
              BlocBuilder<AdsProviderCubit, AdsProviderState>(
                bloc: context.read<AdsProviderCubit>(),
                builder: (context, state) {
                  if (state.isBannerAdLoaded) {
                    return Container(
                      height: 50,
                      width: context.width,
                      child: AdWidget(ad: state.bannerAd!),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Column NoInternetWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "İnternet bağlantınız kesildi. Lütfen bağlantınızı kontrol edin.",
          style: context.textTheme.headline6?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        Lottie.asset(
          Utils.instance.getLottiePath(LottieEnums.angrySasuke),
          height: context.height * 0.3,
        ),
      ],
    );
  }

  Container userButtonsRow(BuildContext context, TimeLimitGuessingState state) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Color(0xff2e3192),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  // todo save game state
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  if (!state.isAnimeTitleActive) {
                    if ((context
                                .read<AppProviderCubit>()
                                .state
                                .user
                                ?.goldCount ??
                            0) >=
                        AppConstants.instance.goldCountForAnswer) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogWithBackground(
                              dialogType: DialogEnums.INTERACTIVE,
                              title: "Kilit Aç",
                              contentText:
                                  "Cevabı açmak için ${AppConstants.instance.goldCountForAnswer} altın harcamak istiyor musunuz?",
                              onConfirm: () {
                                cubit.changeAnimeTitleVisibility(true);
                                context.read<AppProviderCubit>().decrementGold(
                                    AppConstants.instance.goldCountForAnswer);
                                Navigator.pop(context);
                              });
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogWithBackground(
                            onConfirm: () {
                              Navigator.pop(context);
                            },
                            dialogType: DialogEnums.ERROR,
                            title: "Yetersiz Altın",
                            contentText:
                                "Cevabı açmak için ${AppConstants.instance.goldCountForAnswer} altınınız bulunmamaktadır. Reklam izleyerek altın sayınızı artırabilirsiniz.",
                          );
                        },
                      );
                    }
                  }
                },
                child: Text(state.isAnimeTitleActive
                    ? "${state.randomQuestions[state.questionIndex].guessingWord}"
                    : "Cevabı Göster"),
              ),
            ),
            CircleAvatar(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => ShopView(),
                    ),
                  );
                },
                icon: Icon(Icons.shop),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget guessingWordsRow(TimeLimitGuessingState state, BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Table(children: [
            TableRow(
              children: List.generate(
                state.shuffeledList
                    .sublist(0, state.shuffeledList.length ~/ 2)
                    .length,
                (index) {
                  var data = state.shuffeledList.sublist(0, 8)[index];
                  return guessingWordCard(
                    context,
                    guessCardModel: data,
                    isVisible: !data.isHidden,
                    onTap: (() {
                      cubit.addGuessingWord(data);
                    }),
                  );
                },
              ),
            ),
            TableRow(
              children: List.generate(
                state.shuffeledList
                    .sublist(state.shuffeledList.length ~/ 2,
                        state.shuffeledList.length)
                    .length,
                (index) {
                  var data = state.shuffeledList.sublist(
                      state.shuffeledList.length ~/ 2,
                      state.shuffeledList.length)[index];
                  return guessingWordCard(
                    context,
                    guessCardModel: data,
                    isVisible: !data.isHidden,
                    onTap: (() {
                      cubit.addGuessingWord(data);
                    }),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Container guessedWordsRow(
      BuildContext context, TimeLimitGuessingState state) {
    return Container(
      width: context.width,
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: Row(
          children: List.generate(
              state.randomQuestions[state.questionIndex].guessingWord?.length ??
                  0, (index) {
        return Expanded(
            child: IgnorePointer(
          ignoring: state.userGuessedWords[index] == null,
          child: BounceWithoutHover(
            duration: Duration(milliseconds: 100),
            onPressed: () {
              cubit.removeGuessingWord(state.userGuessedWords[index]);
            },
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Text(
                state.userGuessedWords[index]?.guessingWord ?? "",
                textAlign: TextAlign.center,
                style: context.textTheme.headline6
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
      })),
    );
  }

  Container hintImagesGrid(TimeLimitGuessingState state, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                guessContainer(
                    state.randomQuestions[state.questionIndex].answers?[0],
                    context),
                SizedBox(
                  width: 12,
                ),
                guessContainer(
                    state.randomQuestions[state.questionIndex].answers?[1],
                    context),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: Row(
              children: [
                guessContainer(
                    state.randomQuestions[state.questionIndex].answers?[2],
                    context),
                SizedBox(
                  width: 12,
                ),
                guessContainer(
                    state.randomQuestions[state.questionIndex].answers?[3],
                    context,
                    keyCount: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container successPanel(TimeLimitGuessingState state, BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(.7),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          decoration: Utils.instance
              .backgroundDecoration(ImageEnums.background)
              .copyWith(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
          padding: EdgeInsets.all(24),
          margin: EdgeInsets.symmetric(horizontal: 48),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    state.randomQuestions[state.questionIndex].imageUrl ?? ""),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                state.randomQuestions[state.questionIndex].guessingWord ?? "",
                style: context.textTheme.headline5?.copyWith(
                  color: Colors.grey.shade200,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "${state.questionIndex + 1}. karakter başarıyla açıldı.",
                style: context.textTheme.subtitle2
                    ?.copyWith(color: Colors.grey.shade200),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  if (state.questionIndex + 1 == state.randomQuestions.length) {
                    Navigator.pop(context);
                    context.showSnackbar(
                      title: "Tebrikler!",
                      subtitle: "Tebrikler. Testi başarıyla tamamladınız.",
                      icon: Icon(Icons.verified, color: Colors.green),
                      borderColor: Colors.green,
                    );
                  }
                  cubit.switchPanel();
                  cubit.changeQuestion();
                  cubit.setTimeLimit(state.timeLimit +
                      AppConstants
                          .instance.extraTimeForGuessingGameFromCorrectAnswer);
                  // context.read<AppProviderCubit>().updateLevelValue(
                  //     widget.guessingModel.id!, state.questionIndex + 1);
                },
                child: Text("Devam"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget guessingWordCard(BuildContext context,
      {required GuessCardModel guessCardModel,
      required VoidCallback onTap,
      required bool isVisible}) {
    return Visibility(
      visible: isVisible,
      child: BounceWithoutHover(
        duration: Duration(milliseconds: 100),
        onPressed: onTap,
        child: Container(
          margin: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(guessCardModel.guessingWord,
                textAlign: TextAlign.center,
                style: context.textTheme.headline6
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget guessContainer(Answers? image, BuildContext context,
      {int keyCount = 1}) {
    if (image == null) return Spacer();
    print(image.isLocked);
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image.network(
                //   image.url.toString(),
                //   fit: BoxFit.fill,
                //   loadingBuilder: (context, child, loadingProgress) {
                //     if (loadingProgress == null) return child;
                //     return Center(
                //       child: CircularProgressIndicator.adaptive(
                //         value: loadingProgress.expectedTotalBytes != null
                //             ? loadingProgress.cumulativeBytesLoaded /
                //                 loadingProgress.expectedTotalBytes!
                //             : null,
                //       ),
                //     );
                //   },
                // ),
                CachedNetworkImage(
                  imageUrl: image.url.toString(),
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator.adaptive()),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                image.isLocked ?? true
                    ? ((context
                                        .watch<AppProviderCubit>()
                                        .state
                                        .user
                                        ?.keyCount ??
                                    0) -
                                keyCount) >=
                            0
                        ? InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogWithBackground(
                                      dialogType: DialogEnums.INTERACTIVE,
                                      title: "Kilit Aç",
                                      contentText:
                                          "Fotoğrafın kilidini açmak için ${keyCount} anahtar harcayacaksın. Onaylıyor musun?",
                                      onConfirm: () {
                                        cubit.unlockImage(image);
                                        context
                                            .read<AppProviderCubit>()
                                            .decrementKey(keyCount);
                                        Navigator.pop(context);
                                      });
                                },
                              );
                            },
                            child: Container(
                              color: Colors.white,
                              child: Image.asset(
                                Utils.instance.getPNGImage(
                                  ImageEnums.treasureChest,
                                ),
                                width: 56,
                                height: 56,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogWithBackground(
                                    title: "Yetersiz anahtar",
                                    dialogType: DialogEnums.ERROR,
                                    onConfirm: () {
                                      Navigator.pop(context);
                                    },
                                    contentText:
                                        "Fotoğrafın kilidini açmak için yeterli anahtarınız yok. Anahtar satın almak için mağaza sayfasını ziyaret edebilirsiniz.",
                                  );
                                },
                              );
                            },
                            child: Container(
                              color: Colors.white,
                              child: Image.asset(
                                Utils.instance.getPNGImage(
                                  ImageEnums.treasureChest,
                                ),
                                width: 56,
                                height: 56,
                              ),
                            ),
                          )
                    : SizedBox()
              ],
            ),
          ),
          IgnorePointer(
            child: Image.asset(
              Utils.instance.getPNGImage(ImageEnums.border),
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
