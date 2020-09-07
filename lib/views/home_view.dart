import 'package:deethirdapp/widgets/pushnotification_field.dart';

import '../shared/ui_helpers.dart';
import '../views/constants.dart';
import '../viewmodels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      disposeViewModel: false,
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Home Page",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              PushnotificationIconWidget(),
            ],
            backgroundColor: kPrimaryColor,
          ),
          drawer: Drawer(),
          body: Container(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  verticalSpaceMassive,
                  RaisedButton(
                      child: Text("Signout"),
                      onPressed: () {
                        model.signOut();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
