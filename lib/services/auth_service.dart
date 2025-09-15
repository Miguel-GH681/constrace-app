import 'dart:convert';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier{

  late User user;
  bool _loading = false;
  final _storage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async{
    loading = true;

    final data =  {
      'email': email,
      'password': password
    };

    final uri = Uri.http(Environment.apiUrl, '/api/login');
    final res = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    print('body: ${res.body}');

    loading = false;
    if( res.statusCode == 200 ){
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.msg;
      await _saveToken(loginResponse.token);
      return true;
    } else{
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _loading = true;

    final data =  {
      'name': name,
      'email': email,
      'password': password
    };

    final uri = Uri.http(Environment.apiUrl, '/api/login/new');
    final res = await http.post(
        uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json'
        }
    );

    loading = false;
    if( res.statusCode == 200 ){
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.msg;
      await _saveToken(loginResponse.token);
      return true;
    } else{
      return false;
    }
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  static Future<String> getToken() async{
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token') ?? '';
    return token;
  }

  static Future<void> deleteToken() async{
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future _saveToken(String token) async{
    return await _storage.write(key: 'token', value: token);
  }

  Future _logout() async{
    await _storage.delete(key: 'token');
  }

  Future<bool> isLoggedIn() async{
    final token = await _storage.read(key: 'token') ?? '';

    final uri = Uri.http(Environment.apiUrl, '/api/login/renew');
    final res = await http.get(uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );
    if( res.statusCode == 200 ){
      final loginResponse = loginResponseFromJson(res.body);
      user = loginResponse.msg;
      await _saveToken(loginResponse.token);
      return true;
    } else{
      await _logout();
      return false;
    }
  }
}