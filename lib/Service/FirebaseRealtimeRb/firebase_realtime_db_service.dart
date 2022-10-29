import 'package:firebase_database/firebase_database.dart';
import 'package:flutterglobal/Models/personality_test_model.dart';
import 'package:flutterglobal/Service/FirebaseRealtimeRb/i_firebase_realtime_db_service.dart';

class FirebaseRealtimeDBService extends IFirebaseRealtimeDBService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  static FirebaseRealtimeDBService? _instance;

  // DatabaseReference ref = FirebaseDatabase.instance.ref();

  static FirebaseRealtimeDBService get instance {
    return _instance ??= FirebaseRealtimeDBService._init();
  }

  FirebaseRealtimeDBService._init();

  Future<List<PersonalityTestModel>?> getPersonalityQuestionsData() async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("tests/personality/personalityTest/");

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
