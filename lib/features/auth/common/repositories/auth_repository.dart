import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tec_pass/features/auth/common/error_from_server.dart';
import 'package:tec_pass/features/home/cubit/navbar_cubit.dart';
import 'package:tec_pass/helpers/helpers.dart';

class AuthRepository {
  SharedPreferences preferences;
  AuthRepository(this.preferences);
  final baseUrl = 'https://tecpassnode.herokuapp.com/api';

  Future<List<AuthError?>> login({required String email, required String password}) async {
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

    final jsonResponse = json.decode(response.body);

    if (response.statusCode.toString().startsWith('20')) {
      final phoneNumber = phoneToString(jsonResponse['user']['phone']);
      await Future.wait([
        preferences.setString('email', email),
        preferences.setString('name', jsonResponse['user']['name']),
        preferences.setString('accessToken', jsonResponse['accessToken']),
        preferences.setString('refreshToken', jsonResponse['refreshToken']),
        preferences.setString('phone', phoneNumber ?? jsonResponse['user']['phone']),
        preferences.setBool('isLoggedIn', true),
      ]);

      OneSignal.shared.sendTag('phone', phoneNumber ?? jsonResponse['user']['phone']);
      OneSignal.shared.sendTag('email', email);

      return [];
    } else if (response.statusCode.toString().startsWith('40') || response.statusCode.toString().startsWith('40')) {
      return List<AuthError>.from(jsonResponse['errors'].map((error) => AuthError.fromJson(error)));
    }
    return [AuthError(msg: 'No se ha podido autenticar su dirección de correo y contraseña.', param: 'general')];
  }

  Future<List<AuthError?>> register({
    required String name,
    required String email,
    required String phone,
    required String rut,
    required String password,
    required String passwordConfirmation,
  }) async {
    final uri = Uri.parse('$baseUrl/users');
    final body = jsonEncode({
      'name': name,
      'email': email,
      'phone': phoneToString(phone) ?? phone,
      'rut': rut,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
    });

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    log(response.statusCode.toString());
    final jsonResponse = json.decode(response.body);

    if (response.statusCode.toString().startsWith('20')) {
      final phoneNumber = phoneToString(jsonResponse['user']['phone']);
      await Future.wait([
        preferences.setString('email', email),
        preferences.setString('name', name),
        preferences.setString('accessToken', jsonResponse['accessToken']),
        preferences.setString('refreshToken', jsonResponse['refreshToken']),
        preferences.setString('phone', phoneNumber ?? jsonResponse['user']['phone']),
        preferences.setBool('isLoggedIn', true),
      ]);

      OneSignal.shared.sendTag('phone', phoneNumber ?? jsonResponse['user']['phone']);
      OneSignal.shared.sendTag('email', email);

      return [];
    } else if (response.statusCode.toString().startsWith('40') || response.statusCode.toString().startsWith('50')) {
      return List<AuthError>.from(jsonResponse['errors'].map((error) => AuthError.fromJson(error)));
    }
    return [AuthError(msg: 'No se ha podido autenticar su dirección de correo y contraseña.', param: 'general')];
  }

  Future<void> logout(BuildContext context) async {
    if (await LocalAuthentication().canCheckBiometrics) {
      try {
        Future.wait([
          preferences.setBool('isLoggedIn', false),
          OneSignal().deleteTag('email'),
          OneSignal().deleteTag('phone'),
        ]);
      } catch (_) {}
      Navigator.of(context).pushReplacementNamed('relogin');
    } else {
      await deleteSession(context);
      Navigator.of(context).pushReplacementNamed('login');
    }
    BlocProvider.of<NavbarCubit>(context).emit(0);
  }

  Future<void> deleteSession(BuildContext context) async {
    await Future.wait([
      preferences.setBool('isLoggedIn', false),
      preferences.remove('email'),
      preferences.remove('authToken'),
      preferences.remove('refreshToken'),
      preferences.remove('name'),
      preferences.remove('phone'),
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
