import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/message_response.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier{
  late User usuarioTo;
  int projectId = 0;

  Future getChat( int userId, int projectId ) async{
    final uri = Uri.https(Environment.apiUrl, '/api/message/$userId/$projectId');
    final res = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      }
    );

    final messageResponse = messageResponseFromJson(res.body);
    return messageResponse.msg;
  }
}