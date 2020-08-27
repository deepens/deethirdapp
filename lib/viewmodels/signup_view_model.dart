import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../shared/locator.dart';
import '../services/dialog_service.dart';
import '../services/navigation_service.dart';
import '../shared/routing_constants.dart';
import '../services/user_service.dart';
import '../services/auth_service.dart';
import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final UserService _userService = locator<UserService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
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
    token = await _authService.getUserToken();
    showProgressBar(true);
    var result = await _userService.addUsers(
        uemail: email,
        upassword: password,
        utoken: token,
        ufirstname: firstname,
        ulastname: lastname);

    if (result == "success") {
      _navigationService.pop();
      _navigationService.navigateTo(HomePageRoute);
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
    showProgressBar(false);
  }

  void navigateToSignIn() {
    _navigationService.navigateTo(SignInViewPageRoute);
    //_navigationService.pop();
  }

  void navigateToMobileView() {
    _navigationService.navigateTo(SignInMobileViewPageRoute);
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
