import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Core/Constants/app_constants.dart';
import 'package:flutterglobal/Models/sticker_pack_model.dart';
import 'package:flutterglobal/Repositories/firebase_firestore_repository.dart';
import 'package:flutterglobal/Service/Stickers/stickers_service.dart';

part 'stickers_state.dart';

class StickersCubit extends Cubit<StickersState> {
  StickersService stickersService = StickersService.instance;
  var firestoreRepository = FirebaseFirestoreRepository.instance;
  StickersCubit() : super(StickersState()) {
    getStickerPacks(isFirst: true);
  }

  getStickerPacks({bool isFirst = false}) async {
    if (isFirst) {
      _setLoading(true);
    } else {
      _setPaginationLoading(true);
    }

    try {
      List<StickerPackModel> stickerPacks = List.from(state.stickerPacks);
      var data = await firestoreRepository.getStickerPacks(
          isFirst: isFirst, AppConstants.instance.stickerPaginationLimit);
      if (data != null) {
        stickerPacks.addAll(data);
        emit(state.copyWith(stickerPacks: stickerPacks));
      }
    } catch (er) {
      print(er);
    } finally {
      if (isFirst) {
        _setLoading(false);
      } else {
        _setPaginationLoading(false);
      }
    }
  }

  _setPaginationLoading(bool value) {
    emit(state.copyWith(isPaginationLoading: value));
  }

  _setLoading(bool value) {
    emit(state.copyWith(isLoading: value));
  }

  downloadStickers(StickerPackModel? stickerPackModel) async {
    await stickersService.installFromRemote(stickerPackModel);
  }
}
