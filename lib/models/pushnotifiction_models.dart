//import 'package:flutter/material.dart';
class PushNotifictionModel {
  String body;
  String title;
  //String view;

  PushNotifictionModel({this.body, this.title = ""});

  factory PushNotifictionModel.fromJson(Map<String, dynamic> json) {
    return PushNotifictionModel(
      body: json['body'] as String,
      title: json['title'] as String,
      //  view: json['view'] as String,
    );
  }
}
