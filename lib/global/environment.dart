import 'dart:io';

class Environment{
  static String apiUrl = Platform.isAndroid ? '172.16.1.4:3001' : 'http://localhost:3000/api';
  static String socketUrl = Platform.isAndroid ? 'http://172.16.1.4:3001' : 'http://localhost:3000';
}