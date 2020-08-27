//import 'package:flutter/material.dart';
class Users {
  String uid;
  String uemail;
  String upassword;
  String utoken;
  String ufirstname;
  String ulastname;

  Users({this.uid, this.uemail, this.upassword,this.utoken, this.ufirstname="", this.ulastname=""});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      uid: json['uid'] as String,
      uemail: json['uemail'] as String,
      upassword: json['upassword'] as String,
      utoken: json['utoken'] as String,
      ufirstname: json['ufirstname'] as String,
      ulastname: json['ulastname'] as String,
    );
  }
}