//import 'package:flutter/material.dart';
class Users {
  String uid;
  String uemail;
  String upassword;
  String utoken;
  String ufirstname;
  String ulastname;
  String umobileno;
  int uemailverified;
  int umobileverified;
  String ucreated;

  Users(
      {this.uid,
      this.uemail,
      this.upassword,
      this.utoken,
      this.ufirstname = "",
      this.ulastname = "",
      this.umobileno,
      this.uemailverified,
      this.umobileverified,
      this.ucreated});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      uid: json['uid'] as String,
      uemail: json['uemail'] as String,
      upassword: json['upassword'] as String,
      utoken: json['utoken'] as String,
      ufirstname: json['ufirstname'] as String,
      ulastname: json['ulastname'] as String,
      umobileno: json['umobileno'] as String,
      uemailverified: json['uemailverified'] as int,
      umobileverified: json['umobileverified'] as int,
      ucreated: json['ucreated'] as String,
    );
  }
}
