import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/contact.dart';
import 'package:chat_app/models/user_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class UserService{
  Future<List<Contact>> getUsers() async{
    try{
      final uri = Uri.https(Environment.apiUrl, '/api/user');
      final res = await http.get(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          }
      );

      final userResponse = userResponseFromJson(res.body);
      return userResponse.msg;
    } catch(e){
      return [];
    }
  }
}