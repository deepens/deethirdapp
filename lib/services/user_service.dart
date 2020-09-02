import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import '../models/user_models.dart';

class UserService {
  //static const ROOT = 'http://192.168.29.220:81/uindex.php';
  static const ROOT = 'https://chikushah.000webhostapp.com/uindex.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _VERIFY_EMAIL_PHONENO_ACTION = 'VERIFY_EMAIL_PHONENO_ACTION';
  static const _ADD_USER_ACTION = 'ADD_USER';
  static const _UPDATE_USER_ACTION = 'UPDATE_USER';
  static const _DELETE_USER_ACTION = 'DELETE_USER';
  static const _GET_USER_ID = 'GET_USER_ID';
  static const _UPDATE_USER_TOKEN_ID = 'UPDATE_USER_TOKEN_ID';
  Map<String, dynamic> _header = Map();

  header() {
    _header["Content-Type"] = "json";
    //_header["Authorization"] = "json";
    return _header;
  }

  // Method to create the table Userss.
  Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.

      var data = Map<String, dynamic>();
      data['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: data);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error" + e.toString();
    }
  }

  Future<List<Users>> getUsers() async {
    try {
      var data = Map<String, dynamic>();
      data['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: data);
      print('getUserss Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Users> list = parseResponse(response.body);
        return list;
      } else {
        return List<Users>();
      }
    } catch (e) {
      return List<Users>(); // return an empty list on exception/error
    }
  }

  List<Users> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Users>((json) => Users.fromJson(json)).toList();
  }

// Method to verify email id or mobile no exists from Database...
  Future<String> verifyEmailOrPhonenoExist(
      {String uemail, String umobileno}) async {
    try {
      var data = Map<String, dynamic>();
      data['action'] = _VERIFY_EMAIL_PHONENO_ACTION;
      data['uemail'] = uemail ??= '';
      data['umobileno'] = umobileno ??= '';

      final response = await http.post(ROOT, body: data);
      print('verify Email Or PhonenoExist Response: ${response.body}');
      if (200 == response.statusCode) {
        var result = response.body;
        if (result.contains("true")) {
          print("reeeeeeeeeeeeeeeeeetrue -->" + result.toString());
          return "true";
        } else {
          print("reeeeeeeeeeeeeeeeee-->" + response.body.toString());
          return "false";
        }
      } else {
        return "error1";
      }
    } catch (e) {
      return e.toString();
    }
  }

// Method to get specific user id from Database...
  Future<String> getUserIdBasedonEmail(String uemail, String upassword) async {
    try {
      var data = Map<String, dynamic>();
      data['action'] = _GET_USER_ID;
      data['uemail'] = uemail;
      data['upassword'] = upassword;

      final response = await http.post(ROOT, body: data);
      print('get user id Response: ${response.body}');
      if (200 == response.statusCode) {
        var result = response.body;
        if (result.contains("Duplicate")) {
          return "In valid email id or password";
        } else {
          return response.body;
        }
      } else {
        return "error1";
      }
    } catch (e) {
      return e.toString();
    }
  }

// Method to get specific user id from Database...
  Future<String> getUserIdBasedonPhoneNo(String umobileno) async {
    try {
      var data = Map<String, dynamic>();
      data['action'] = _GET_USER_ID;
      data['umobileno'] = umobileno;

      final response = await http.post(ROOT, body: data);
      print('get user id Response: ${response.body}');
      if (200 == response.statusCode) {
        var result = response.body;
        if (result.contains("Duplicate")) {
          return "Mobileno does not exist";
        } else {
          return response.body;
        }
      } else {
        return "error1";
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Method to add Users to the database...
  Future addUsers(
      {String uemail,
      String upassword,
      String utoken,
      String ufirstname,
      String ulastname,
      String umobileno,
      String uemailverified,
      String umobileverified,
      String ucreated}) async {
    try {
      var data = Map<String, dynamic>();
      data["action"] = _ADD_USER_ACTION;
      data["uemail"] = uemail ??= '';
      data['upassword'] = upassword ??= '';
      data['utoken'] = utoken ??= '';
      data['ufirstname'] = ufirstname ??= '';
      data['ulastname'] = ulastname ??= '';
      data['umobileno'] = umobileno ??= '';
      data['uemailverified'] = uemailverified ??= '0';
      data['umobileverified'] = umobileverified ??= '0';
      //data['ucreated'] = ucreated ??= 'NOVALUE';
      //print("############" + data.toString());
      data.forEach((k, v) => print('$k: $v'));

      final response = await http.post(ROOT, body: data);
      print('addUsers Response: ${response.body}');
      if (200 == response.statusCode) {
        var result = response.body;
        if (result.contains("Duplicate")) {
          return "E-mail id already registered,Please try using another E-mail id";
        } else {
          return response.body;
        }
      } else {
        return "error1";
      }
    } on Exception catch (e) {
      if (e.toString().contains('Duplicate')) {
        return "E-mail id already registered,Please try using another E-mail id";
      } else {
        return "Unknown error occured, please try login after some time";
      }
    }
  }

  // Method to update an Users in Database...
  Future<String> updateUsers(
      String uid, String uemail, String upassword, String utoken) async {
    try {
      var data = Map<String, dynamic>();
      data['action'] = _UPDATE_USER_ACTION;
      data['uid'] = uid;
      data['uemail'] = uemail;
      data['upassword'] = upassword;
      data['utoken'] = utoken;
      final response = await http.post(ROOT, body: data);
      print('updateUsers Response: ${response.body}');
      if (200 == response.statusCode) {
        var result = response.body;
        if (result.contains("error")) {
          return "Unable to update User record, Please try after sometime.";
        } else {
          return response.body;
        }
      } else {
        return "error1";
      }
    } catch (e) {
      if (e.toString().contains('Duplicate')) {
        return "Unable to update User record,Please try after sometime";
      } else {
        return "Unknown error occured, please try login after some time";
      }
    }
  }

// Method to update an Users in Database...
  Future<String> updateUserToken(String uid, String utoken) async {
    try {
      var data = Map<String, dynamic>();
      data['action'] = _UPDATE_USER_TOKEN_ID;
      data['uid'] = uid;
      data['utoken'] = utoken;
      //print("uid->"+uid);
      var head = data['application/json'];
      final response = await http.post(ROOT, body: data, headers: head);
      print('update User token Response: ${response.body}');
      if (200 == response.statusCode) {
        var result = response.body;
        if (result.contains("error")) {
          return "Unable to update user token, Please try after sometime.";
        }
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error->" + e.toString();
    }
  }

  // Method to Delete an Users from Database...
  Future<String> deleteUsers(String uid) async {
    try {
      var data = Map<String, dynamic>();
      data['action'] = _DELETE_USER_ACTION;
      data['uid'] = uid;
      final response = await http.post(ROOT, body: data);
      print('deleteUsers Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}
