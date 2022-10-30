part of 'stickers_cubit.dart';

class StickersState extends Equatable {
  bool isLoading;
  List<StickerPackModel>? stickerPacks;

  StickersState({this.isLoading = false, this.stickerPacks});

  @override
  List<Object?> get props => [isLoading, stickerPacks];

  StickersState copyWith(
      {bool? isLoading, List<StickerPackModel>? stickerPacks}) {
    return StickersState(
        isLoading: isLoading ?? this.isLoading,
        stickerPacks: stickerPacks ?? this.stickerPacks);
  }
}
