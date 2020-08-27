import '../views/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../views/src/circle.dart';

class LoadingService {

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
     
    return showDialog<void>(
      
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                return Future.value(
                    false); //return a `Future` with false value so this route cant be popped or closed.
              },
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Center(
                        child: Column(children: [
                          SizedBox(
                            height: 5,
                          ),
                          SpinKitCircle(color: kPrimaryColor),
                          // CircularProgressIndicator(
                          //   valueColor: AlwaysStoppedAnimation<Color>(
                          //       Colors.blueAccent),
                          //   backgroundColor: Colors.white,
                          //   strokeWidth: 5,
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Please Wait....",
                            style: TextStyle(color: Colors.purple),
                          )
                        ]),
                      ),
                    ),
                  ]));
        });
  }

  static Widget showNoInternetDialog(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return Future.value(
              false); //return a `Future` with false value so this route cant be popped or closed.
        },
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            height: 300.0,
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'No Network: Please check your internet is active',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      RaisedButton(
                        color: Colors.red,
                        onPressed: () => {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop'),
                        },
                        child: Text(
                          'Eixt',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
