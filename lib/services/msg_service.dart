// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';

class MsgService{
  
 // final FirebaseMessaging _fmsg = FirebaseMessaging();
 
  
  
}
  
  // Future<void> getFirebaseMessagingtoken() async {

  //   try{
  //   await _fmsg.getToken().then((_devicetokenno) {
  //     if(_devicetokenno!=null){
  //     _token = _devicetokenno.toString();
     
  //     }
     
  //   });
  //   }on Exception catch (e) {
  //     print(errormsg=e.toString());
  //   }
  // }

  // void pushNotification() {
  //   _fmsg.configure(
  //     onMessage: (message) async {
  //       _title = message["notification"]["title"];
  //       _helper = message["notification"]["body"];
  //       _userdata = message["data"]["key1"];
        
  //     },
  //     onResume: (message) async {
  //       _title = message["notification"]["title"];
  //       _helper = message["notification"]["body"];
  //       _userdata = message["data"]["key1"];
        
  //     },

  //     onBackgroundMessage: (message) async {
  //       _title = message["notification"]["title"];
  //       _helper = message["notification"]["body"];
  //       _userdata = message["data"]["key1"];
        
  //     },
  //   );
  // }