import 'package:deethirdapp/viewmodels/pushnotification_view_model.dart';
//import 'package:deethirdapp/widgets/pushnotification_field.dart';
import 'package:hive/hive.dart';
//import 'package:hive_flutter/hive_flutter.dart';

import '../shared/ui_helpers.dart';
import 'constants.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PushNotificationlistView extends StatelessWidget {
  const PushNotificationlistView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var box = Hive.box('pushNotificationMessageBox');

    //List<Map<dynamic, dynamic>> data = ;
    return ViewModelBuilder<PushnotificationViewModel>.reactive(
      viewModelBuilder: () => PushnotificationViewModel(),
      disposeViewModel: false,
      //onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Notification List",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            //PushnotificationIconWidget(),
          ],
          backgroundColor: kPrimaryColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  verticalSpaceSmall,
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: box.length,
                  //   itemBuilder: (context, index) {
                  //     List<dynamic> response = box.etAt(index);
                  //     return ListTile(
                  //       title: Text(response[index]["title"] ?? ""),
                  //       subtitle: Text(response[index]["body"] ?? ""),
                  //     );
                  //   },
                  // ),
                  ValueListenableBuilder(
                      valueListenable: Hive.box<List<Map<String, dynamic>>>(
                              'pushNotificationMessageBox')
                          .listenable(),
                      builder: (context, box, widget) {
                        return Center(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: box.length,
                            itemBuilder: (context, index) {
                              List<dynamic> response = box.getAt(index);
                              return ListTile(
                                title: Text(response[index]["title"] ?? ""),
                                subtitle: Text(response[index]["body"] ?? ""),
                              );
                            },
                          ),
                        );
                      }),

                  Divider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
