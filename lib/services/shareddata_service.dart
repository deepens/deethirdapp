import 'package:shared_preferences/shared_preferences.dart';

class SharedDataService {
  SharedPreferences _sharedData;

  initialise() async {
    if (_sharedData == null) {
      _sharedData = await SharedPreferences.getInstance();
    } else {
      print("------------>${_sharedData.toString()}");
    }
  }

  setSharedData(String key, String value) {
    if (_sharedData != null) {
      _sharedData.setString(key, value.toString());
    } else {
      print("no SP instance");
    }
  }

  getSharedData(String key) {
    return _sharedData.getString(key) ?? '';
  }
}
