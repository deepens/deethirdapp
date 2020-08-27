//import 'package:flutter/material.dart';
class Users {
  String id;
  String uemail;
  String upassword;
  String utoken;

  Users({this.id, this.uemail, this.upassword,this.utoken});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'] as String,
      uemail: json['uemail'] as String,
      upassword: json['upassword'] as String,
      utoken: json['utoken'] as String,
    );
  }
}