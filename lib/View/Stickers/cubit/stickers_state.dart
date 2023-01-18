part of 'stickers_cubit.dart';

class StickersState extends Equatable {
  bool isLoading;
  bool isPaginationLoading = false;
  List<StickerPackModel> stickerPacks;

  StickersState(
      {this.isLoading = false,
      this.stickerPacks = const [],
      this.isPaginationLoading = false});

  @override
  List<Object?> get props => [isLoading, stickerPacks, isPaginationLoading];

  StickersState copyWith(
      {bool? isLoading,
      List<StickerPackModel>? stickerPacks,
      bool? isPaginationLoading}) {
    return StickersState(
        isLoading: isLoading ?? this.isLoading,
        stickerPacks: stickerPacks ?? this.stickerPacks,
        isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading);
  }
}
