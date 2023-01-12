import 'dart:ffi';

class User {
  String _id;
  String name;
  String countryCode;
  String email;
  String phone;
  String upiId;
  bool verified;

  User(
    this._id,
    this.name,
    this.countryCode,
    this.email,
    this.phone,
    this.upiId,
    this.verified
  );
  factory User.fromJson(Map<String, dynamic> json){
    return User(
      json['_id'] as String,
      json['name'] as String,
      json['country_code'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['upi_id'] as String,
      json['verified'] as bool,
      );
  }
  Map<String, dynamic> toJson() => {
    'name':name,
    'country_code':countryCode,
    'phone':phone,
    'upi_id':upiId,
  };
}