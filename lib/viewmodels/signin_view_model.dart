import 'package:flutter/material.dart';
import '../services/shareddata_service.dart';
import '../services/user_service.dart';
import '../shared/routing_constants.dart';
import '../shared/locator.dart';
import '../services/auth_service.dart';
import '../services/navigation_service.dart';
import '../viewmodels/base_model.dart';
import '../shared/shareddata_constants.dart';

class SignInViewModel extends BaseModel {
  final AuthService _authService = locator<AuthService>();
  //final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedDataService _sharedDataService = locator<SharedDataService>();
  //final GlobalKey<State> _progressDialogLoader = GlobalKey<State>();
  final UserService _userService = locator<UserService>();

  Future signIn(
      {@required String email,
      @required String password,
      BuildContext context}) async {
    showProgressBar(true);
    //LoadingService.showLoadingDialog(context,_progressDialogLoader) ;
    var result = await _userService.getUserIdBasedonEmail(email, password);

    if (result != null || result.length >= 1) {
      String token;
      token = await _authService.getUserToken();
      _sharedDataService.setSharedData(USERTOKEN, token);

      var isloggedin = await _userService.updateUserToken(result, token);
      if (isloggedin == "success") {
        setErrormessage("");
        showProgressBar(false);
        _sharedDataService.setSharedData(ISUSERLOGGEDIN, YES);

        _navigationService.navigateTo(HomePageRoute);
      } else {
        _sharedDataService.setSharedData(ISUSERLOGGEDIN, NO);

        setErrormessage("Sign In failed , In correct e-mail id or password");
        showProgressBar(false);
      }
    } else {
      _sharedDataService.setSharedData(ISUSERLOGGEDIN, NO);

      setErrormessage("Sign In failed , In correct e-mail id or password");
      showProgressBar(false);
    }
  }

  void navigateToSignUp() {
    _navigationService.pop();
    _navigationService.navigateTo(SignupViewPageRoute);
  }

  void navigateToMobileView() {
    _navigationService.navigateTo(SignInMobileViewPageRoute);
    //_navigationService.pop();
  }

  // @override
  // void dispose() {
  //   //WidgetsBinding.instance.removeObserver();
  //   super.dispose();
  //   print("------------------------------->dispose:signin");
  // }
}
