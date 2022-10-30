import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Init/Cache/locale_manager.dart';
import 'package:flutterglobal/Models/wallpaper_model.dart';
import 'package:flutterglobal/Models/personality_test_model.dart';
import 'package:flutterglobal/Service/FirebaseRealtimeRb/firebase_realtime_db_i18.dart';
import 'package:flutterglobal/Service/FirebaseRealtimeRb/firebase_realtime_db_service.dart';
import 'package:flutterglobal/Service/FirebaseRealtimeRb/i_firebase_realtime_db_service.dart';
import 'package:flutterglobal/Service/PackageInfo/package_info.dart';

class RealtimeDBRepository extends IFirebaseRealtimeDBService {
  static RealtimeDBRepository? _instance;
  static RealtimeDBRepository get instance {
    if (_instance == null) _instance = RealtimeDBRepository._init();
    return _instance!;
  }

  RealtimeDBRepository._init();
  CacheManager _cacheManager = CacheManager.instance;
  @override
  Future<List<PersonalityTestModel>?> getPersonalityQuestionsData() async {
    // eğer eski sürümse bu kısmı çalıştır değilse else kısmı çalışacak bunu uygulama açılırken versiyonlama ile kontrol edip yapacağız sürüm numarası kaydedilebilir bir yerlere
    if ((int.tryParse(
                PackageInfoService.instance.packageInfo?.buildNumber ?? "0") ??
            0) <
        13) {
      return await FirebaseRealtimeDBService.instance
          .getPersonalityQuestionsData();
    } else {
      return await FirebaseRealtimeDBI18.instance.getPersonalityQuestionsData();
    }
  }
}
