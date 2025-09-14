import 'dart:developer';
import 'dart:io';

import 'package:chat_app/models/message_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final textController = TextEditingController();
  final focusNode = FocusNode();
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;
  List<ChatMessage> messages = [];

  bool isWriting = false;

  @override
  void initState() {
    super.initState();

    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);
    socketService.socket.on('mensaje-personal', _listenMessage);
    _loadHistory( chatService.usuarioTo.userId );
  }

  void _loadHistory(int usuarioTo) async{
    final chat = await chatService.getChat(usuarioTo);
    chat.forEach((message){
      messages.insert(0, ChatMessage(
          text: message.message,
          uid: message.senderId,
          animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 0))..forward()
      ));
    });
    setState(() { });
  }

  void _listenMessage(dynamic payload){
    log('payload $payload');
    ChatMessage message = ChatMessage(
        text: payload['message'],
        uid: payload['from'],
        animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 300))
    );
    messages.insert(0, message);
    setState(() {
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    final userTo = chatService.usuarioTo;

    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              maxRadius: 14,
              child: Text(userTo.fullName.substring(0,2), style: TextStyle(fontSize: 12)),
            ),
            SizedBox(height: 3),
            Text(
                userTo.fullName,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12
              ),
            )
          ],
        ),
        elevation: 1,
        centerTitle: true,
        backgroundColor: Colors.white
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (_,i) => messages[i],
                itemCount: messages.length,
                reverse: true,
              ),
            ),
            Divider( height: 1 ),
            Container(
              color: Colors.white,
              height: 70,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto){
                  setState(() {
                    if(texto.trim().length > 0){
                      isWriting = true;
                    } else{
                      isWriting = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: 'Enviar mensaje'
                ),
                focusNode: focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
              ? CupertinoButton(
                  child: Text('Enviar'),
                  onPressed: (){}
              )
              : Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: IconTheme(
                  data: IconThemeData( color: Colors.blue[400] ),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.send ),
                    onPressed: isWriting
                      ? ()=> _handleSubmit(textController.text.trim())
                      : null
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text){
    if(text.isEmpty) return;

    textController.clear();
    focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: text,
      uid: authService.user.userId,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
      ),
    );
    messages.insert(0,newMessage);
    newMessage.animationController.forward();

    setState(() {
      isWriting = false;
    });

    socketService.socket.emit('mensaje-personal', {
      'sender_id': authService.user.userId,
      'receiver_id': chatService.usuarioTo.userId,
      'message': text,
      'send_date': DateTime.now().toString()
    });
  }

  @override
  void dispose() {
    for(ChatMessage message in messages){
      message.animationController.dispose();
    }
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}
