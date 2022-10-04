import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'ads_provider_state.dart';

class AdsProviderCubit extends Cubit<AdsProviderState> {
  AdsProviderCubit() : super(AdsProviderState()) {
    getInitialRewardAd();
    getBannerAd();
  }

  void setAd(RewardedAd ad) {
    emit(state.copyWith(ad: ad));
  }

  void setWallpaperAd(RewardedAd ad) {
    emit(state.copyWith(adForWallpaper: ad));
  }

  void setBannerAd(BannerAd? ad) {
    emit(state.copyWith(bannerAd: ad));
  }

  Future<void> getBannerAd() async {
    state.bannerAd?.dispose();

    setBannerAd(null);

    final BannerAd myBanner = BannerAd(
      // adUnitId: 'ca-app-pub-9258462632949376/2480690775',
      adUnitId: "ca-app-pub-3940256099942544/6300978111",
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('Ad loaded.');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
      ),
    );

    await myBanner.load();
    setBannerAd(myBanner);
  }

  void getInitialRewardAd() {
    RewardedAd.load(
        request: AdRequest(),
        // test reklam id
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            setAd(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ));
  }

  Future<void> getWallpaperRewardAd() async {
    // gerçek id : ca-app-pub-9258462632949376/8719075308
    await RewardedAd.load(
        request: AdRequest(),
        // test reklam id
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            setWallpaperAd(ad);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
          },
        ));
  }
}
