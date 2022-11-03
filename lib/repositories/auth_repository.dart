import 'dart:convert';

import 'package:demo/config.dart';
import 'package:http/http.dart';

import '../models/all.dart';

class AuthRepository {
  Future<User> register(String username, String password, String phone) async {
    final url = Uri.https(lcApiBase, '/1.1/users');
    final response = await post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'X-LC-Id': lcAppId,
          'X-LC-Key': lcAppKey
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'phone': phone,
        }));
    switch (response.statusCode) {
      case 201:
        final json = jsonDecode(response.body);
        final auth = Auth.fromJson(json);
        final user = getMyInfoBySessionToken(auth.sessionToken);
        return user;
      case 400:
        final json = jsonDecode(response.body);
        final error = json['error'];
        throw Exception(error);
      default:
        throw Exception('Failed to register');
    }
  }

  Future<User> login(String username, String password) async {
    final response = await post(Uri.https(lcApiBase, '/1.1/login'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'X-LC-Id': lcAppId,
          'X-LC-Key': lcAppKey
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }));
    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.body);
        return User.fromJson(json);
      case 400:
        final json = jsonDecode(response.body);
        final error = json['error'];
        throw Exception(error);
      default:
        throw Exception('Failed to register');
    }
  }

  Future<User> getUser(String objectId) async {
    final response =
        await get(Uri.https(lcApiBase, '/1.1/users/$objectId'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'X-LC-Id': lcAppId,
      'X-LC-Key': lcAppKey
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json);
    }
    throw Exception('Failed to get user.');
  }

  Future<User> getMyInfoBySessionToken(String sessionToken) async {
    final response = await get(Uri.https(lcApiBase, '/1.1/users/me'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'X-LC-Id': lcAppId,
      'X-LC-Key': lcAppKey,
      'X-LC-Session': sessionToken
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json);
    }
    throw Exception('Failed to get my information.');
  }
}
