import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

part 'ads_provider_state.dart';

class AdsProviderCubit extends Cubit<AdsProviderState> {
  AdsProviderCubit() : super(AdsProviderState()) {
    getInitialRewardAd();
  }

  void setAd(RewardedAd ad) {
    emit(state.copyWith(ad: ad));
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
}
