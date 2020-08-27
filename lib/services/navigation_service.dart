import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    //print(arguments.data.toString());
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToAndClearBackStack(String routeName,
      {dynamic arguments}) {
    //print(arguments.data.toString());
    return _navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  unloadprogressbar(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
