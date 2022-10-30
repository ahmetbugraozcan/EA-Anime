import 'package:firebase_database/firebase_database.dart';
import 'package:flutterglobal/Core/Constants/Enums/application_enums.dart';
import 'package:flutterglobal/Core/Init/Cache/locale_manager.dart';
import 'package:flutterglobal/Models/personality_test_model.dart';

import 'i_firebase_realtime_db_service.dart';

class FirebaseRealtimeDBI18 extends IFirebaseRealtimeDBService {
  static FirebaseRealtimeDBI18? _instance;

  // DatabaseReference ref = FirebaseDatabase.instance.ref();

  static FirebaseRealtimeDBI18 get instance {
    return _instance ??= FirebaseRealtimeDBI18._init();
  }

  FirebaseRealtimeDBI18._init();

  @override
  Future<List<PersonalityTestModel>?> getPersonalityQuestionsData() async {
    DatabaseReference ref = CacheManager.instance
                .getStringValue(PreferencesKeys.LANGUAGE) ==
            LanguageEnums.EN.name
        ? FirebaseDatabase.instance
            .ref("tests/personality/personalityTestEnglish/")
        : FirebaseDatabase.instance.ref("tests/personality/personalityTest/");

    var data = await ref.get();
    if (data.exists) {
      Map<String, dynamic> jsonData = Map.from(data.value as Map);

      List<PersonalityTestModel> list = [];
      (jsonData["data"] as List).forEach((element) {
        if (element == null) return;
        list.add(PersonalityTestModel.fromJson(Map.from(element as Map)));
      });

      return list;
    }
    return null;
  }
}
