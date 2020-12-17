import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPref with ChangeNotifier {
  SharedPreferences prefs;
  final String nameKey = 'username';
  final String filePathKey = 'filePath';
  final String loginKey = 'isLogin';
  bool _isLogin = false;
  var userData = {
    'username': '',
    'imagepath': '',
  };

  ///save user data
  void save(String name, String filePath) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(nameKey, name);
    await prefs.setString(filePathKey, filePath);
    await prefs.setBool(loginKey, true);

    notifyListeners();
    print('UserPref: data saved');
  }

  ///get user data
  Future<Map<String, String>> fetchData() async {
    prefs = await SharedPreferences.getInstance();
    userData['username'] = prefs.getString(nameKey) ?? 'User';
    userData['imagepath'] = prefs.getString(filePathKey) ?? null;

    print('UserPref: data fetched');
    return userData;
  }

  ///check if user already logged in
  Future<void> isLoggedIn() async {
    prefs = await SharedPreferences.getInstance();
    //is user login data saved
    _isLogin = prefs.getBool(loginKey) ?? false;
    notifyListeners();
  }

  bool get isLogin {
    isLoggedIn();
    return _isLogin;
  }
}
