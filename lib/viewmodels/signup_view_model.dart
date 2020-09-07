import 'package:deethirdapp/services/shareddata_service.dart';
import 'package:deethirdapp/shared/shareddata_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../shared/locator.dart';

import '../services/navigation_service.dart';
import '../shared/routing_constants.dart';
import '../services/user_service.dart';
import '../services/auth_service.dart';
import '../shared/shareddata_constants.dart';
import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final UserService _userService = locator<UserService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedDataService _sharedDataService = locator<SharedDataService>();
  final AuthService _authService = locator<AuthService>();

  String uemail;
  String upassword;
  String utoken;
  String ufirstname = "";
  String ulastname = "";
  bool isuserloggedin = false;

  Future signUp(
      {@required String email,
      @required String password,
      @required String firstname,
      BuildContext context}) async {
    String lastname;
    lastname ??= '';
    String token;

    showProgressBar(true);
    var _emailorphoneexist =
        await _userService.verifyEmailOrPhonenoExist(uemail: email);
    print(">>>>>>>>>>" + _emailorphoneexist.toString());
    if (_emailorphoneexist == "true") {
      setErrormessage("Email ID already resistered, please try another ID");
    } else {
      token = await _authService.getUserToken();

      var result = await _userService.addUsers(
          uemail: email,
          upassword: password,
          utoken: token,
          ufirstname: firstname,
          ulastname: lastname);

      if (result == "success") {
        setErrormessage("");

        _sharedDataService.setSharedData(ISUSERLOGGEDIN, YES);
        _navigationService.navigateTo(HomePageRoute);
      } else {
        setErrormessage("Signup Failed, Please try after some time");
        showProgressBar(false);
      }
    }
    showProgressBar(false);
  }

  void navigateToSignIn() {
    _navigationService.navigateTo(SignInViewPageRoute);
    //_navigationService.pop();
  }
}
// *** another way of loading dialog ***
//LoadingService.showLoadingDialog(context,_progressDialogLoader) ;
// showProgressBar(true,context);
//showProgressBar(false,context);
//Navigator.of(_progressDialogLoader.currentContext, rootNavigator: true).pop();
//print("------>$result");
// *** another way of loading dialog ***
