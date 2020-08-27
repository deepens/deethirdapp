import 'dart:convert';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import './users.dart';

class Uservices {
  static const ROOT = 'http://192.168.29.220:81/uindex.php';
  //static const ROOT = 'https://chikushah.000webhostapp.com/uindex.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_USER_ACTION = 'ADD_USER';
  static const _UPDATE_USER_ACTION = 'UPDATE_USER';
  static const _DELETE_USER_ACTION = 'DELETE_USER';
  static const _GET_USER_ID = 'GET_USER_ID';
  static const _UPDATE_USER_TOKEN_ID = 'UPDATE_USER_TOKEN_ID';

  // Method to create the table Userss.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"+e.toString();
    }
  }

  static Future<List<Users>> getUsers() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
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

  static List<Users> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Users>((json) => Users.fromJson(json)).toList();
  }

// Method to get specific user id from Database...
  static Future<String> getUserid(String uemail, String upassword) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_USER_ID;
      map['uemail'] = uemail;
      map['upassword'] = upassword;
     
      final response = await http.post(ROOT, body: map);
      print('get user id Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
  // Method to add Users to the database...
  static Future<String> addUsers(String uemail, String upassword,String utoken) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_USER_ACTION;
      map['uemail'] = uemail;
       map['upassword'] = upassword;
      map['utoken'] = utoken;
      final response = await http.post(ROOT, body: map);
      print('addUsers Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Users in Database...
  static Future<String> updateUsers(
      String uid, String uemail, String upassword, String utoken) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_USER_ACTION;
      map['uid'] = uid;
       map['uemail'] = uemail;
      map['upassword'] = upassword;
      map['utoken'] = utoken;
      final response = await http.post(ROOT, body: map);
      print('updateUsers Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

// Method to update an Users in Database...
  static Future<String> updateUserToken(String uid, String utoken) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_USER_TOKEN_ID;
      map['uid'] = uid;
      map['utoken'] = utoken;
      //print("uid->"+uid);
      final response = await http.post(ROOT, body: map);
      print('update User token Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error=>";
      }
    } catch (e) {
      return "error->"+ e.toString();
    }
  }
  // Method to Delete an Users from Database...
  static Future<String> deleteUsers(String uid) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_USER_ACTION;
      map['uid'] = uid;
      final response = await http.post(ROOT, body: map);
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