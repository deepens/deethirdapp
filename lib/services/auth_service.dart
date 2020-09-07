import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import '../models/user_models.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _fmsg = FirebaseMessaging();

  String _errormsg;
  Users _currentUser;
  String phoneNo, verificationId, smsCode;
  //String _title;
  Users get currentUser => _currentUser;

  bool _smsCodeExpired = false;

  bool isSMSCodeExpired() {
    return _smsCodeExpired;
  }

  setSMSCodeExpired(value) {
    _smsCodeExpired = value;
  }

  isUserLoggedIn() async {
    try {
      var user = currentUser;
      //print(user.getIdToken().toString());
      return user != null;
    } on Exception catch (e) {
      _errormsg = e.toString();
      print("auth_Service_isUserLoggedIn:" + _errormsg.toString());
      return false;
    }
  }

  Future logout() async {
    var result = _auth.signOut();

    return result;
  }

  Future loginUser({String email, String password}) async {
    try {
      print("Inside: loginUser function-->" + email + password);
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return true;
    } on Exception catch (e) {
      //print(e);

      if (e.toString().contains('ERROR_WRONG_PASSWORD')) {
        return "Password is invalid";
      } else if (e.toString().contains('ERROR_USER_NOT_FOUND')) {
        return "User id does not exist";
      } else if (e.toString().contains('ERROR_TOO_MANY_REQUESTS')) {
        return "Too many unsuccessful login attempts. Please try again later.";
      } else {
        return "Unknown error occured, please try login after some time";
      }
    }
  }

  Future signUpUser({String email, String password}) async {
    try {
      print("Inside: signUpUser function-->" + email + password);
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on Exception catch (e) {
      print(e);

      if (e.toString().contains('ERROR_WEAK_PASSWORD')) {
        return "Password should be at least 6 characters";
      } else if (e.toString().contains('ERROR_EMAIL_ALREADY_IN_USE')) {
        return "The email address is already in use by another account.";
      } else if (e.toString().contains('ERROR_TOO_MANY_REQUESTS')) {
        return "Too many unsuccessful login attempts. Please try again later.";
      } else {
        return "Unknown error occured, please try login after some time";
      }
    }
  }

  Future signOutUser() async {
    try {
      print("Inside: signoutUser function...");
      await _auth.signOut();

      return true;
    } catch (e) {
      print("--->" + e.toString());
      _errormsg = e;

      return false;
    }
  }

  Future signInWithOTP(smsCode, verId) async {
    print(smsCode.toString());
    print(verId.toString());
    //try {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);

    try {
      var firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(authCreds);
      print("Login Successful");
      print(firebaseUser.user);
      return true;
    } catch (e) {
      print(e.toString());
      if (e.toString().contains("ERROR_INVALID_VERIFICATION_CODE")) {
        return "The sms verification code used to create the phone auth credential is invalid";
      } else if (e.toString().contains("ERROR_SESSION_EXPIRED")) {
        return "The sms code has expired. Please re-send the verification code to try again.";
      } else {
        return "UnKnown error occured, Please try after some time";
      }
    }
  }

  Future getUserToken() async {
    try {
      var result = await _fmsg.getToken().then((value) => value.toString());
      // print("--->>>>>>"+result.toString());
      return result != null ? result.toString() : "false";
    } on Exception catch (e) {
      _errormsg = e.toString();
      print("auth_Service_isUserLoggedIn:" + _errormsg.toString());
      return _errormsg;
    }
  }

  // void pushNotification() {
  //   //String _helper, _userdata, _token;
  //   _fmsg.configure(
  //     onMessage: (message) async {
  //       // _title = message["notification"]["title"];
  //       // _helper = message["notification"]["body"];
  //       // _userdata = message["data"]["key1"];
  //     },
  //     onResume: (message) async {
  //       // _title = message["notification"]["title"];
  //       // _helper = message["notification"]["body"];
  //       // _userdata = message["data"]["key1"];
  //     },
  //     onBackgroundMessage: (message) async {
  //       // _title = message["notification"]["title"];
  //       // _helper = message["notification"]["body"];
  //       // _userdata = message["data"]["key1"];
  //     },
  //   );
  // }
}
