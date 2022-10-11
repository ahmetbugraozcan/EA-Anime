part of 'ads_provider_cubit.dart';

class AdsProviderState {
  RewardedAd? ad;
  InterstitialAd? adForTop10;
  bool isAdLoading;
  BannerAd? bannerAd;

  RewardedAd? adForWallpaper;
  AdsProviderState(
      {this.ad,
      this.isAdLoading = false,
      this.bannerAd,
      this.adForWallpaper,
      this.adForTop10});

  // List<Object?> get props => [ad, isAdLoading, bannerAd, adForWallpaper];

  AdsProviderState copyWith({
    RewardedAd? ad,
    bool? isAdLoading,
    BannerAd? bannerAd,
    RewardedAd? adForWallpaper,
    InterstitialAd? adForTop10,
  }) {
    return AdsProviderState(
      ad: ad ?? this.ad,
      isAdLoading: isAdLoading ?? this.isAdLoading,
      bannerAd: bannerAd ?? this.bannerAd,
      adForWallpaper: adForWallpaper ?? this.adForWallpaper,
      adForTop10: adForTop10 ?? this.adForTop10,
    );
  }
}
