import 'package:deethirdapp/models/pushnotifiction_models.dart';
import 'package:deethirdapp/services/pushnotification_service.dart';
import 'package:deethirdapp/shared/locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'base_model.dart';

class PushnotificationViewModel extends BaseModel {
  //final NavigationService _navigationService = locator<NavigationService>();
  final PushNotificationService _pushNotificationService =
      locator<PushNotificationService>();
  final FirebaseMessaging _fmsg = FirebaseMessaging();

  Map<String, dynamic> _message;
  String _pushNotificationtitle, _pushNotificationbody;
  List<Map<String, dynamic>> _messageList = List();

  var listOfMessage = List<Map<String, dynamic>>();
  get messageList => _messageList;

  set messageList(val) {
    _messageList.add(val);
    notifyListeners();
  }

  get message => _message;
  setMessage(val) {
    _message = val;
  }

  PushNotifictionModel _pushNotifiction = PushNotifictionModel();
  PushNotifictionModel get pushNotifiction => _pushNotifiction;

  List<PushNotifictionModel> _pushNotificatonList = List();

  //String _pushNotificationtitle, _pushNotificationbody;
  int _pushNotificationcount = 0;

  get pushNotificationTitle => _pushNotificationtitle;

  setPushNotificationTitle(val) {
    _pushNotificationtitle = val;
    //_pushNotificationtitle["title"] = val;
    //_message.addAll(_pushNotificationtitle);
    notifyListeners();
  }

  get pushNotificationBody => _pushNotificationbody;

  setPushNotificationBody(val) {
    _pushNotificationbody = val;
    //_pushNotificationbody["body"] = val;
    //_message.addAll(_pushNotificationbody);
    notifyListeners();
  }

  get pushNotificationCount => _pushNotificationcount;

  setPushNotificationCount() {
    _pushNotificationcount = _pushNotificationcount + 1;
    notifyListeners();
  }

  Future initialise() async {
    _fmsg.configure(
      // Called when the app is in the foreground and we receive a push notification
      onMessage: (Map<String, dynamic> message) async {
        setPushNotificationTitle(message["notification"]["title"]);
        setPushNotificationBody(message["notification"]["body"]);
        setPushNotificationCount();
        // print('onMessage: ' + pushNotificationTitle.toString());
        // print('onMessage: ' + pushNotificationBody.toString());
        // listOfMessage.add(
        //     {"title": pushNotificationTitle, "body": pushNotificationBody});
        // for (var entry in listOfMessage) {
        //   print(entry["title"] + ":" + entry["body"]);
        //   //print(welcomelist.length);

        // }
        addMessageToMessageList({
          "title": pushNotificationTitle.toString(),
          "body": pushNotificationBody.toString()
        });
        //setMessage(message);
        // _pushNotificatonList.add(_pushNotifiction);

        //_message["body"] = pushNotificationBody;
        // messageList(_message);
        // print("Message List Size:" + _messageList.length.toString());
        // _messageList.forEach((element) {
        //   print(
        //       "Message List Title:" + element.containsKey("title").toString());
        // });
      },

      // Called when the app has been closed comlpetely and it's opened
      // from the push notification.
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        setPushNotificationTitle(message["notification"]["title"]);
        setPushNotificationBody(message["notification"]["body"]);
        setPushNotificationCount();
        print('onLaunch: ' + pushNotificationTitle.toString());
        print('onLaunch: ' + pushNotificationBody.toString());
        //setMessage(message);
        //addPushNotification();
      },
      // Called when the app is in the background and it's opened
      // from the push notification.
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        setPushNotificationCount();
        setPushNotificationTitle(message["notification"]["title"]);
        setPushNotificationBody(message["notification"]["body"]);
        print('onResume: ' + pushNotificationTitle.toString());
        print('onResume: ' + pushNotificationBody.toString());
        //setMessage(message);
      },
    );
  }

  addMessageToMessageList(Map<String, dynamic> val) {
    listOfMessage.add({"title": val["title"], "body": val["body"]});
    for (var entry in listOfMessage) {
      print(entry["title"] + ":" + entry["body"]);
    }
  }
  // addPushNotification() {
  //   print('onaddPushNotification: $message');
  //   setPushNotificationTitle(message["notification"]["title"] ?? '');
  //   setPushNotificationBody(message["notification"]["body"] ?? '');
  //   _pushNotifiction.title = pushNotificationTitle;

  //   _pushNotifiction.body = pushNotificationBody;
  //   _pushNotificatonList.add(_pushNotifiction);
  //   print("#######" + _pushNotificatonList[0].title.toString());
  // }
}
