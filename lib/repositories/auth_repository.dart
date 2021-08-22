import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tec_pass/bloc/customnavbar/customnavbar_bloc.dart';
import 'package:tec_pass/bloc/error_from_server.dart';

class AuthRepository {
  SharedPreferences preferences;
  AuthRepository(this.preferences);
  final baseUrl = 'https://tecpassnode.herokuapp.com/api';
  final bearerToken = 'da1b47293a770649913670717a2835ff';

  Future<List<Error?>> login({required String email, required String password}) async {
    final uri = Uri.parse('$baseUrl/auth/login');
    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    print('response: ' + response.body);

    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      await Future.wait([
        preferences.setString('email', email),
        preferences.setString('name', jsonResponse['user']['name']),
        preferences.setString('token', jsonResponse['token']),
      ]);
      return [];
    } else if (response.statusCode == 400) {
      return List<Error>.from(jsonResponse['errors'].map((error) => Error.fromJson(error)));
    }
    return [Error(msg: 'No se ha podido autenticar su dirección de correo y contraseña.')];
  }

  Future<List<Error?>> register({
    required String name,
    required String email,
    required String phone,
    required String rut,
    required String password,
  }) async {
    final uri = Uri.parse('$baseUrl/users');
    final body = jsonEncode({
      'name': name,
      'email': email,
      'phone': phone,
      'rut': rut,
      'password': password,
    });

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    log(response.statusCode.toString());
    final jsonResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      await Future.wait([
        preferences.setString('email', jsonResponse['user']['email']),
        preferences.setString('name', jsonResponse['user']['name']),
        preferences.setString('token', jsonResponse['token']),
      ]);
      return [];
    } else if (response.statusCode == 400) {
      return List<Error>.from(jsonResponse['errors'].map((error) => Error.fromJson(error)));
    }
    return [Error(msg: 'No se ha podido autenticar su dirección de correo y contraseña.')];
  }

  Future<void> logout(BuildContext context) async {
    if (await LocalAuthentication().canCheckBiometrics) {
      await preferences.setBool('isLoggedIn', false);
      Navigator.of(context).pushReplacementNamed('relogin');
    } else {
      await deleteSession(context);
      Navigator.of(context).pushReplacementNamed('login');
    }
    BlocProvider.of<CustomNavBarBloc>(context).add(Access());
  }

  Future<void> deleteSession(BuildContext context) async {
    await Future.wait([
      preferences.setBool('isLoggedIn', false),
      preferences.remove('email'),
      preferences.remove('token'),
      preferences.remove('name'),
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
