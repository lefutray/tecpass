import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  SharedPreferences preferences;
  AuthRepository(this.preferences);

  Future<bool> login({required String email, required String password}) async {
    print('attempting login');
    await Future.delayed(Duration(seconds: 2));
    print('logged in');
    await Future.wait([
      preferences.setString('email', email),
      preferences.setString('password', password),
    ]);

    return true;
  }

  Future<bool> register({
    required String fullName,
    required String mobile,
    required String rut,
    required String email,
    required String password,
  }) async {
    print('attempting login');
    await Future.delayed(Duration(seconds: 2));
    if (await Future.value(true)) {
      print('logged in');
      await Future.wait([
        preferences.setString('email', email),
        preferences.setString('password', password),
      ]);
      return true;
    }
    return false;
  }

  Future<void> logout(BuildContext context) async {
    await preferences.setBool('isLoggedIn', false);
    Navigator.of(context).pushReplacementNamed('login');
  }

  Future<void> deleteSession(BuildContext context) async {
    await Future.wait([
      preferences.setBool('isLoggedIn', false),
      preferences.remove('email'),
      preferences.remove('password'),
    ]);
    Navigator.of(context).pushReplacementNamed('login');
  }

  Future<bool?> relogin(BuildContext context) async {
    if (preferences.containsKey('email')) {
      await preferences.setBool('isLoggedIn', true);
      Navigator.of(context).pushReplacementNamed('home');
      return true;
    }
    return false;
  }
}
