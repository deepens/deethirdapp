//import 'dart:io';

import 'package:deethirdapp/services/navigation_service.dart';
import 'package:deethirdapp/shared/locator.dart';
import 'package:deethirdapp/shared/routing_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';

class PushNotificationService {
  //final FirebaseMessaging _fcm = FirebaseMessaging();
  //final NavigationService _navigationService = locator<NavigationService>();
  var _pushNotificationMessageBox;
  final NavigationService _navigationService = locator<NavigationService>();

  final FirebaseMessaging _fmsg = FirebaseMessaging();
  get pushNotificationMessageBox => _pushNotificationMessageBox;

  set pushNotificationMessageBox(val) {
    _pushNotificationMessageBox =
        Hive.openBox(val.toString()); //pushNotificationMessageBox
  }

  Future openPushNotificationMessageBox(val) async {
    _pushNotificationMessageBox = Hive.box(val.toString());
  }

  Map<String, dynamic> _message;
  String _pushNotificationtitle, _pushNotificationbody;
  List<Map<String, dynamic>> _messageList = List();

  var listOfMessage = List<Map<String, dynamic>>();
  get messageList => _messageList;

  set messageList(val) {
    _messageList.add(val);
  }

  get message => _message;
  setMessage(val) {
    _message = val;
  }

  int _pushNotificationcount = 0;

  get pushNotificationTitle => _pushNotificationtitle;

  setPushNotificationTitle(val) {
    _pushNotificationtitle = val;
    //_pushNotificationtitle["title"] = val;
    //_message.addAll(_pushNotificationtitle);
  }

  get pushNotificationBody => _pushNotificationbody;

  setPushNotificationBody(val) {
    _pushNotificationbody = val;
  }

  get pushNotificationCount => _pushNotificationcount;

  setPushNotificationCount() {
    _pushNotificationcount = _pushNotificationcount + 1;
  }

  Future initialise() async {
    //_fmsg.requestNotificationPermissions();
    _fmsg.configure(
        // Called when the app is in the foreground and we receive a push notification
        onMessage: (Map<String, dynamic> message) async {
          setPushNotificationTitle(message["notification"]["title"]);
          setPushNotificationBody(message["notification"]["body"]);

          addMessageToMessageList({
            "title": pushNotificationTitle.toString(),
            "body": pushNotificationBody.toString()
          });
        },
        onBackgroundMessage: myBackgroundMessageHandler,

        // Called when the app has been closed comlpetely and it's opened
        // from the push notification.
        onLaunch: (Map<String, dynamic> message) async {
          print('onLaunch: $message');
          setPushNotificationTitle(message["data"]["title"]);
          setPushNotificationBody(message["data"]["body"]);
          // if (pushNotificationTitle != null || pushNotificationBody != null) {
          //   addMessageToMessageList({
          //     "title": pushNotificationTitle.toString(),
          //     "body": pushNotificationBody.toString()
          //   });
          // }
        },
        // Called when the app is in the background and it's opened
        // from the push notification.
        onResume: (Map<String, dynamic> message) async {
          print('onResume: $message');

          //setPushNotificationCount();
          setPushNotificationTitle(message["data"]["title"]);
          setPushNotificationBody(message["data"]["body"]);
          if (pushNotificationTitle != null || pushNotificationBody != null) {
            addMessageToMessageList({
              "title": pushNotificationTitle.toString(),
              "body": pushNotificationBody.toString()
            });
          }
        });
  }

  addMessageToMessageList(Map<String, dynamic> val) async {
    //print("%%%%" + {"title": val["title"], "body": val["body"]}.toString());

    if (val["title"].toString() != "null" && val["body"] != "null") {
      listOfMessage.add({"title": val["title"], "body": val["body"]});
      //await openPushNotificationMessageBox('PushNotificationMessageBox');
      _pushNotificationMessageBox =
          Hive.box<List<Map<String, dynamic>>>('pushNotificationMessageBox');
      _pushNotificationMessageBox.add(listOfMessage);
      setPushNotificationCount();
      //pushNotificationMessageBox('pushNotificationMessageBox');
      List<dynamic> response;
      for (var index = 0; index < _pushNotificationMessageBox.length - 1;) {
        response = await _pushNotificationMessageBox.getAt(index);
        if (response != null) {
          print("===========" + response[index]["title"].toString() ?? "");
        }
        index++;
      }
    }
  }

  void navigateToPushNotificationListView() {
    _navigationService.navigateTo(PushnotificationListViewPageRoute);
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    print('AppPushs myBackgroundMessageHandler : $message');
    return Future<void>.value();
  }
}
