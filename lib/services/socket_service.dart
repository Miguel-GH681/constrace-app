import 'package:chat_app/global/environment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';

enum ServerStatus{
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier{
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  void connect() async{

    final token = await AuthService.getToken();

    _socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': token
      }
    });

    _socket.onConnect((_) {
      serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.onDisconnect((_){
      serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect(){
    _socket.disconnect();
  }

  ServerStatus get serverStatus => _serverStatus;


  set serverStatus(ServerStatus value) {
    _serverStatus = value;
    notifyListeners();
  }

  IO.Socket get socket => _socket;
}