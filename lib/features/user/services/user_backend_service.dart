import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:tec_pass/features/app/app.dart';

class UserBackendService {
  static final UserBackendService _instance = UserBackendService._();
  factory UserBackendService() => _instance;
  UserBackendService._();

  final String _baseUrl = 'https://tecpassnode.herokuapp.com/api';

  final app = App();

  bool accessTokenExpired() {
    final accessToken = app.accessToken;
    if (accessToken == null) return true;
    final timeLeft = JwtDecoder.getRemainingTime(accessToken);
    if (timeLeft.isNegative || timeLeft.inMinutes < 1) return true;
    return false;
  }

  Future<String?> regenerateAccessToken() async {
    final refreshToken = app.refreshToken;
    if (refreshToken == null) return null;

    final response = await http.post(
      Uri.parse('$_baseUrl/auth/token'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $refreshToken',
      },
    );

    if (response.statusCode.toString().startsWith('20')) {
      final body = json.decode(response.body);
      return body['accessToken'];
    } else {
      Fluttertoast.showToast(msg: 'La sesión ha expirado: ${response.body}');
    }
  }

  Future<bool> getValidAccessToken(BuildContext context) async {
    final accessToken = app.accessToken;
    final refreshToken = app.refreshToken;

    if (accessToken == null || refreshToken == null) {
      app.authRepository.logout(context);
      Fluttertoast.showToast(msg: 'La sesión ha expirado');
      return false;
    }

    if (accessTokenExpired()) {
      final newAccessToken = await regenerateAccessToken();
      if (newAccessToken == null) {
        Fluttertoast.showToast(msg: 'La sesión ha expirado');
        return false;
      }
      await app.preferences.setString('accessToken', newAccessToken);
    }
    return true;
  }

  Future<bool> changePhoto(String? photo, String accessToken) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/users/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: json.encode({'image': photo.toString()}),
    );

    return response.statusCode.toString().startsWith('20');
  }
}
