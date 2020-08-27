import 'package:flutter/material.dart';
import '../models/pushnotifiction_models.dart';

class PushNotificationView extends StatelessWidget {
  final PushNotifiction data;
  PushNotificationView({this.data});
  @override
  Widget build(BuildContext context) {
    print("===================>"+ data.title);
    return Scaffold(
      appBar: AppBar(
        //title: Text(‘Constructor — second page’),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              height: 54.0,
            ),
          Text("Title: ${data.title}"),
          //  Text('Message: ${data.body}'),
            
          ],
        ),
      ),
    );
  }
}