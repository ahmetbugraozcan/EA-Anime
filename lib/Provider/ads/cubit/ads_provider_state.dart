part of 'ads_provider_cubit.dart';

class AdsProviderState extends Equatable {
  RewardedAd? ad;
  bool isAdLoading;
  BannerAd? bannerAd;
  RewardedAd? adForWallpaper;
  AdsProviderState(
      {this.ad, this.isAdLoading = false, this.bannerAd, this.adForWallpaper});

  List<Object?> get props => [ad, isAdLoading, bannerAd, adForWallpaper];

  AdsProviderState copyWith({
    RewardedAd? ad,
    bool? isAdLoading,
    BannerAd? bannerAd,
    RewardedAd? adForWallpaper,
  }) {
    return AdsProviderState(
      ad: ad ?? this.ad,
      isAdLoading: isAdLoading ?? this.isAdLoading,
      bannerAd: bannerAd ?? this.bannerAd,
      adForWallpaper: adForWallpaper ?? this.adForWallpaper,
    );
  }
}
