// import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static Future<void> saveUser(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
      final prefs2 = await SharedPreferences.getInstance();
      await prefs2.setString('islogin', 'false');
  }

  // static Future<Map<String, String>> getUser(String username, String password) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // final username = prefs.getString('username') ?? '';
  //   // final password = prefs.getString('password') ?? '';
  //   // return {'username': username, 'password': password};
  //  return prefs.getString('username') === username? true:  false;
  // }

  static Future<bool> getUser(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    // final username = prefs.getString('username') ?? '';
    // final password = prefs.getString('password') ?? '';
    // return {'username': username, 'password': password};
    var islogin = prefs.getString('username') == username &&
        prefs.getString('password') == password;
    if (islogin) {
      final prefs2 = await SharedPreferences.getInstance();
      await prefs2.setString('islogin', 'true');
    } else {
      final prefs2 = await SharedPreferences.getInstance();
      await prefs2.setString('islogin', 'false');
    }
    return (prefs.getString('username') == username &&
            prefs.getString('password') == password)
        ? true
        : false;
  }

  static Future<bool> islogin() async {
    final prefs = await SharedPreferences.getInstance();
    final c = prefs.getString('islogin') == 'true' ? true : false;
    return c;
  }
}
