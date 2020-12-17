import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  SharedPreferences prefs;
  final String nameKey = 'username';
  final String filePathKey = 'filePath';
  var userData = {
    'username': '',
    'imagepath': '',
  };

  ///save user data
  void save(String name, String filePath) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString(nameKey, name);
    await prefs.setString(filePathKey, filePath);

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
}
