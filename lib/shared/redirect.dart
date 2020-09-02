import 'package:flutter/material.dart';
import '../shared/routing_constants.dart';
import '../nopagefound.dart';
import '../views/home_view.dart';
import '../views/signin_view.dart';
import '../views/signup_view.dart';
import '../views/signin_Mobile_view.dart';

Route<dynamic> redirectingtopage(RouteSettings page) {
  switch (page.name) {
    case HomePageRoute:
      return MaterialPageRoute(builder: (context) => HomeView());
    case SignInViewPageRoute:
      return MaterialPageRoute(builder: (context) => SignInView());
    case SignupViewPageRoute:
      return MaterialPageRoute(builder: (context) => SignUpView());
    // case PushNotificationViewPageRoute:
    //   return MaterialPageRoute(builder: (context) => PushNotificationView());
    case SignInMobileViewPageRoute:
      return MaterialPageRoute(builder: (context) => SignInMobileView());

    default:
      return MaterialPageRoute(
          builder: (context) => NoPageFound(name: page.name));
  }
}
