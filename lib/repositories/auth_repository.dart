import 'package:demo/config.dart';
import 'package:dio/dio.dart';

import '../models/all.dart';

class AuthRepository {
  final Dio dio;

  AuthRepository(this.dio);

  Future<User> register(String username, String password, String phone) async {
    final url = Uri.https(lcApiBase, '/1.1/users');
    final response = await dio.postUri(url, data: {
      'username': username,
      'password': password,
      'phone': phone,
    });
    switch (response.statusCode) {
      case 201:
        final json = response.data;
        final auth = Auth.fromJson(json);
        final user = getMyInfoBySessionToken(auth.sessionToken);
        return user;
      case 400:
        final json = response.data;
        final error = json['error'];
        throw Exception(error);
      default:
        throw Exception('Failed to register');
    }
  }

  Future<User> login(String username, String password) async {
    final response =
        await dio.postUri(Uri.https(lcApiBase, '/1.1/login'), data: {
      'username': username,
      'password': password,
    });
    switch (response.statusCode) {
      case 200:
        final json = response.data;
        return User.fromJson(json);
      case 400:
        final json = response.data;
        final error = json['error'];
        throw Exception(error);
      default:
        throw Exception('Failed to register');
    }
  }

  Future<User> getUser(String objectId) async {
    final response =
        await dio.getUri(Uri.https(lcApiBase, '/1.1/users/$objectId'));
    if (response.statusCode == 200) {
      final json = response.data;
      return User.fromJson(json);
    }
    throw Exception('Failed to get user.');
  }

  Future<User> getMyInfoBySessionToken(String sessionToken) async {
    final response = await dio.getUri(Uri.https(lcApiBase, '/1.1/users/me'));
    if (response.statusCode == 200) {
      final json = response.data;
      return User.fromJson(json);
    }
    throw Exception('Failed to get my information.');
  }
}
