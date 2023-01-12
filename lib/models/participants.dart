import 'dart:ffi';

import 'package:splitr/models/usermodel.dart';

class Participants {
  String trip;
  User user;
  String name;
  Double paid;
  Double owed;
  bool isSettled;

  Participants(
    this.trip,
    this.user,
    this.name,
    this.paid,
    this.owed,
    this.isSettled,
  );
  factory Participants.fromJson(Map<String, dynamic> json){
    User user = User("","","","","","",false);
    if(json.containsKey('user')){
      user = User.fromJson(json['user']);
    }
    return Participants(
      json['trip'] as String,
      user,
      json['name'] as String,
      json['paid'] as Double,
      json['owed'] as Double,
      json['is_settled'] as bool,
      );
  }
  Map<String, dynamic> toJson() => {
    'name':name,
  };
}