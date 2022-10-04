import 'package:flutterglobal/Models/guessing_model.dart';

class GuessingDataModel {
  List<GuessingModel>? guessingModels;
  int? userLastLevel;

  GuessingDataModel({this.guessingModels, this.userLastLevel});

  GuessingDataModel.fromJson(Map<String, dynamic> json) {
    userLastLevel = json['userLastLevel'];

    if (json['data'] != null) {
      guessingModels = <GuessingModel>[];
      json['data'].forEach((v) {
        guessingModels!
            .add(new GuessingModel.fromJson(Map<String, dynamic>.from(v)));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.guessingModels != null) {
      data['data'] = this.guessingModels!.map((v) => v.toJson()).toList();
    }
    data['userLastLevel'] = this.userLastLevel;
    return data;
  }
}
