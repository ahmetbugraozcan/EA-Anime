import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutterglobal/Service/FirebaseRealtimeRb/firebase_realtime_db_service.dart';

part 'wallpaper_anime_names_state.dart';

class WallpaperAnimeNamesCubit extends Cubit<WallpaperAnimeNamesState> {
  FirebaseRealtimeDBService firebaseRealtimeDBService =
      FirebaseRealtimeDBService.instance;
  WallpaperAnimeNamesCubit() : super(WallpaperAnimeNamesState());
}
