import 'dart:io';

class Environment{
  static String apiUrl = Platform.isAndroid ? '172.16.0.218:3000' : 'http://localhost:3000/api';
  static String socketUrl = Platform.isAndroid ? 'http://172.16.0.218:3000' : 'http://localhost:3000';
}