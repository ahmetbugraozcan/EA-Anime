part of 'ads_provider_cubit.dart';

class AdsProviderState extends Equatable {
  RewardedAd? ad;
  bool isAdLoading;

  AdsProviderState({this.ad, this.isAdLoading = false});

  List<Object?> get props => [ad, isAdLoading];

  AdsProviderState copyWith({
    RewardedAd? ad,
    bool? isAdLoading,
  }) {
    return AdsProviderState(
      ad: ad ?? this.ad,
      isAdLoading: isAdLoading ?? this.isAdLoading,
    );
  }
}
