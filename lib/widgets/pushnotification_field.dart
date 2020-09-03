import 'package:badges/badges.dart';
import 'package:deethirdapp/views/constants.dart';

import '../viewmodels/pushnotification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PushnotificationIconWidget
    extends ViewModelBuilderWidget<PushnotificationViewModel> {
  @override
  bool get reactive => true;

  @override
  bool get createNewModelOnInsert => false;

  @override
  bool get disposeViewModel => true;

  // @override
  // bool get fireOnModelReadyOnce => false;

  @override
  Widget builder(
    BuildContext context,
    PushnotificationViewModel model,
    Widget child,
  ) {
    return Badge(
      position: BadgePosition.topRight(right: 3, top: 10),
      badgeColor: kPrimaryColor,
      shape: BadgeShape.circle,
      toAnimate: true,
      animationType: BadgeAnimationType.scale,
      alignment: Alignment.topRight,
      //animationDuration: Duration(milliseconds: 1000),
      borderRadius: 5,
      //padding: EdgeInsets.all(),
      badgeContent: Text(model.pushNotificationCount.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
      child: IconButton(
        icon: Icon(
          Icons.notifications,
          size: 45,
          textDirection: TextDirection.ltr,
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  void onViewModelReady(PushnotificationViewModel model) {
    model.initialise();

    super.onViewModelReady(model);
  }

  @override
  PushnotificationViewModel viewModelBuilder(BuildContext context) =>
      PushnotificationViewModel();
}
