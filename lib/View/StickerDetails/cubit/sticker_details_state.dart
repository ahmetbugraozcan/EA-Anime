part of 'sticker_details_cubit.dart';

class StickerDetailsState extends Equatable {
  bool isLoading;
  StickerDetailsState({this.isLoading = false});

  @override
  List<Object?> get props => [isLoading];

  StickerDetailsState copyWith({bool? isLoading}) {
    return StickerDetailsState(isLoading: isLoading ?? this.isLoading);
  }
}
