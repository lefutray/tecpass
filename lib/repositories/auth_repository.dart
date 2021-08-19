import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  SharedPreferences preferences;
  AuthRepository(this.preferences);
  final baseUrl = 'https://joobyapp.bubbleapps.io/version-test/api/1.1/wf/';
  final bearerToken = 'da1b47293a770649913670717a2835ff';

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
    final uri = Uri.parse('${baseUrl}registro_tecpass');

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $bearerToken',
      },
      body: {
        'nombre': fullName,
        'rut': rut,
        'celular': mobile,
        'correo': email,
        'password': password,
        'projects': '["1629311633987x789879915594998900"]',
      },
    );

    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      await Future.wait([
        preferences.setString('email', email),
        preferences.setString('password', password),
      ]);
      return true;
    }
    return false;
  }

  Future<void> logout(BuildContext context) async {
    if (await LocalAuthentication().canCheckBiometrics) {
      await preferences.setBool('isLoggedIn', false);
    } else {
      await deleteSession(context);
    }
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
