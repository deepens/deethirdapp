import 'package:flutter/widgets.dart';
import '../services/navigation_service.dart';
import '../shared/locator.dart';
import '../models/user_models.dart';
import '../services/auth_service.dart';
import '../services/loading_service.dart';

class BaseModel extends ChangeNotifier {
  final AuthService _authenticationService = locator<AuthService>();
  final GlobalKey<State> _progressDialogLoader = GlobalKey<State>();
  Users get currentUser => _authenticationService.currentUser;
  final NavigationService _navigationService = locator<NavigationService>();
  bool _busy = false;

//  String _smsCode = '';

  bool get busy => _busy;
  bool _smsCodeExpired = false;

  bool isSMSCodeExpired() {
    return _smsCodeExpired;
  }

  setSMSCodeExpired(value) {
    _smsCodeExpired = value;
    notifyListeners();
  }

  String _errormessage = '';

  String getErrormessage() {
    return _errormessage;
  }

  setErrormessage(value) {
    _errormessage = value;
    notifyListeners();
  }

  void showProgressBar(bool value) {
    _busy = value;
    if (_busy == true) {
      //print("Processing Started.....");
      LoadingService.showLoadingDialog(
          _navigationService.navigationKey.currentContext,
          _progressDialogLoader);
    } else {
      // Navigator ==null ? context.findAncestorStateOfType<NavigatorState>()
      // :context.findRootAncestorStateOfType<NavigatorState>();

      //print("Processing Finished .....");
      Navigator.of(_navigationService.navigationKey.currentContext,
              rootNavigator: true)
          .pop();
    }

    notifyListeners();
  }
}
