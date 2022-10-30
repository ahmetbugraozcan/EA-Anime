import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Models/sticker_pack_model.dart';
import 'package:flutterglobal/Repositories/firebase_firestore_repository.dart';
import 'package:flutterglobal/Service/Stickers/stickers_service.dart';

part 'stickers_state.dart';

class StickersCubit extends Cubit<StickersState> {
  StickersService stickersService = StickersService.instance;
  var firestoreRepository = FirebaseFirestoreRepository.instance;
  StickersCubit() : super(StickersState()) {
    getStickerPacks();
  }

  getStickerPacks() async {
    _setLoading(true);
    try {
      var data = await firestoreRepository.getStickerPacks();
      _setStickerPacks(data);
    } catch (er) {
      print(er);
    } finally {
      _setLoading(false);
    }
  }

  _setStickerPacks(List<StickerPackModel>? data) {
    emit(state.copyWith(stickerPacks: data));
  }

  _switchLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  _setLoading(bool value) {
    emit(state.copyWith(isLoading: value));
  }

  downloadStickers() async {
    _setLoading(true);
    await stickersService
        .installFromRemote(state.stickerPacks!.first.stickerUrls!);
    _setLoading(false);
  }
}
