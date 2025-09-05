import 'dart:io';

class Environment{
  static String apiUrl = Platform.isAndroid ? 'constrace.onrender.com' : 'http://localhost:3000/api';
  static String socketUrl = Platform.isAndroid ? 'https://constrace.onrender.com' : 'http://localhost:3000';
}