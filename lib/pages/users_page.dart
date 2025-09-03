import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final userService = UserService();
  RefreshController refreshController = RefreshController(initialRefresh: false);
  List<User> users = [];

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text(authService.user.fullName),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: Icon(Icons.exit_to_app)
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            // child: Icon(Icons.offline_bolt, color: Colors.red),
            child: socketService.serverStatus == ServerStatus.Online
            ? Icon(Icons.check_circle, color: Colors.blue[400])
            : Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check_circle, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400]!,
        ),
        onRefresh: _cargarUsuarios,
        child: _userListView(),
      ),
    );
  }

  ListView _userListView() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _userListTile(users[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: users.length,
    );
  }

  ListTile _userListTile(User user) {
    return ListTile(
      title: Text(user.fullName),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        child: Text(user.fullName.substring(0,2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          // color: user.online ? Colors.green[300] : Colors.red,
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(100)
        ),
      ),
      onTap: (){
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioTo = user;
        Navigator.pushNamed(context, 'chat');
      },
    );
  }

  _cargarUsuarios() async{
    users = await userService.getUsers();
    setState(() {  });
    refreshController.refreshCompleted();
  }
}

