import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;

class UserBackendService {
  static final UserBackendService _instance = UserBackendService._();
  factory UserBackendService() => _instance;
  UserBackendService._();

  final String _baseUrl = 'https://tecpassnode.herokuapp.com/api';

  bool accessTokenExpired(String accessToken) {
    final timeLeft = JwtDecoder.getRemainingTime(accessToken);
    if (timeLeft.isNegative || timeLeft.inMinutes < 1) return true;
    return false;
  }

  Future<String?> regenerateAccessToken(String refreshToken) async {
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

  Future<bool> changePhoto(String photo, String accessToken) async {
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
