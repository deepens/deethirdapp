import 'dart:async';
import 'package:deethirdapp/services/navigation_service.dart';
import 'package:deethirdapp/services/user_service.dart';
import 'package:deethirdapp/shared/locator.dart';
import 'package:deethirdapp/shared/routing_constants.dart';
import 'package:deethirdapp/viewmodels/base_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignInMobileViewModel extends BaseModel {
  final formKey = new GlobalKey<FormState>();

  final AuthService _auth = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();

  //final GlobalKey<State> _progressDialogLoader = GlobalKey<State>();
  String _phoneNo, _verificationId, smsCode;
  int _forceResendingToken;
  bool codeSent = false;

  setverificationId(String val) {
    _verificationId = val;
    //notifyListeners();
  }

  String verificationId() {
    return _verificationId;
  }

  setCodeSent(val) {
    codeSent = val;
    notifyListeners();
  }

  bool _resetOTPTimer = false;
  //Timer _timer;

  bool _displayResendButton = false;

  bool get displayResendButton => _displayResendButton;

  setdisplayResendButton(val) {
    _displayResendButton = val;
    notifyListeners();
  }

  get resendOPT => _start;
  setresendOTP(val) {
    _start = val;
    if (val < 1) {
      setdisplayResendButton(true);
    } else {
      setdisplayResendButton(false);
    }
    notifyListeners();
  }

  get resetOTPTimer => _resetOTPTimer;

  setresetOTPTimer(val) {
    _resetOTPTimer = val;
    if (val == 30) {
      _start = 30;
      startTimer();
    }
    notifyListeners();
  }

  setphoneNo(val) {
    _phoneNo = val;
    notifyListeners();
  }

  get phoneNo => _phoneNo;

  int _start = 30;
  startTimer() {
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) {
      if (_start < 1) {
        timer.cancel();
        setdisplayResendButton(true);
        //print(
        //   "iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$_start$resendOPT()");
      } else {
        _start = _start - 1;
        setresendOTP(_start);
      }
      //print("------------------$resendOPT");
    });
  }

  Future enterPhoneNo({phoneNo, BuildContext context}) async {
    showProgressBar(true);
    try {
      //print("**************************" + phoneNo.toString());

      setphoneNo(phoneNo);
      final PhoneVerificationCompleted verified =
          (AuthCredential authResult) async {
        await FirebaseAuth.instance
            .signInWithCredential(authResult)
            .then((value) {
          if (value.user != null) {
            setErrormessage('Authentication successful');

            _navigationService.navigateTo(HomePageRoute);
          } else {
            setErrormessage('Invalid code/invalid authentication');
          }
        }).catchError((error) {
          setErrormessage('Something has gone wrong, please try later');
          //showProgressBar(false);
        });
        // if (value.user != null) {
        //   setErrormessage(
        //       '***********************************Authentication successful');
        //   var response = await signUp(phoneno: phoneNo);
        //   if (response == true) {
        //     _navigationService.navigateTo(HomePageRoute);
        //   } else {
        //     setErrormessage("value");
        //   }
        // } else {
        //   setErrormessage('Invalid code/invalid authentication');
        //   //showProgressBar(false);
        // }
      };

      final PhoneVerificationFailed verificationfailed =
          (FirebaseAuthException authException) {
        if (authException.message
            .contains("The format of the phone number provided is incorrect")) {
          setErrormessage("The format or phone number provided is incorrect");
        } else if (authException.message.contains('not authorized')) {
          setErrormessage('Something has gone wrong, please try later');
        } else if (authException.message.contains('Network')) {
          setErrormessage(
              'Please check your internet connection and try again');
        } else {
          setErrormessage('Something has gone wrong, please try later');
        }

        //print('${authException.message}');
        //showProgressBar(false);
      };

      final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
        this._verificationId = verId;
        this._forceResendingToken = forceResend;
        setCodeSent(true);
      };

      final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
        this._verificationId = verId;
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNo,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verified,
          verificationFailed: verificationfailed,
          codeSent: smsSent,
          forceResendingToken: _forceResendingToken,
          codeAutoRetrievalTimeout: autoTimeout);
      //setCodeSent(true);
      showProgressBar(false);
      startTimer();
    } catch (e) {
      showProgressBar(false);
      setErrormessage(e.toString());
    }
  }

  signInUsingOTP({String smsCode, BuildContext context}) async {
    showProgressBar(true);
    var result = await _auth.signInWithOTP(smsCode, verificationId());
    if (result == true) {
      var response = await signUp(phoneno: phoneNo);
      if (response == true) {
        setErrormessage("");

        _navigationService.navigateTo(HomePageRoute);
        print("iiiiiiiiiiiiiiiiiiiiiiaaaaaaaaaaaaaaaaaaaahhhhhhhhhhhhhhhhhhh");
      } else {
        setErrormessage(
            "Mobile no already registered, Please try using another number.");
      }
    } else {
      setErrormessage(result);
    }
    showProgressBar(false);
    print(" Outside_2->$result");
  }

  bool isuserloggedin = false;

  Future signUp({@required String phoneno, BuildContext context}) async {
    try {
      showProgressBar(true);
      String token;
      print("i am heeeeeeeeeeeee");
      token = await _auth.getUserToken();

      var result;
      result = await _userService.verifyEmailOrPhonenoExist(umobileno: phoneno);
      if (result == "false") {
        result = await _userService.addUsers(umobileno: phoneno, utoken: token);
      }
      showProgressBar(false);
      return true;
    } catch (e) {
      setErrormessage(
          "Error Logging using mobile no, Please try after some time.");
      showProgressBar(false);
      return false;
    }
  }
}
