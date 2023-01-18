import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/sticker_pack_model.dart';
import 'package:flutterglobal/Service/Stickers/stickers_service.dart';

part 'sticker_details_state.dart';

class StickerDetailsCubit extends Cubit<StickerDetailsState> {
  StickerDetailsCubit() : super(StickerDetailsState());

  void changeLoadingState(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  // install sticker pack
  Future<void> installStickerPack(StickerPackModel stickerPackModel) async {
    changeLoadingState(true);
    await StickersService.instance.installFromRemote(stickerPackModel);
    changeLoadingState(false);
  }
}
