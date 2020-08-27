//import 'package:flutter/material.dart';
class PushNotifiction {
  String body;
  String title;
  String view;
  

  PushNotifiction({this.body, this.title="", this.view=""});

  factory PushNotifiction.fromJson(Map<String, dynamic> json) {
    return PushNotifiction(
      body: json['body'] as String,
      title: json['title'] as String,
      view: json['view'] as String,
      
    );
  }
}