import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/pages/project_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(authService.user.fullName, style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 7,
        shadowColor: AppColors.darkBackgroundColor,
        backgroundColor: AppColors.secondary,
        leading: IconButton(
          onPressed: (){
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: Icon(Icons.exit_to_app)
        ),
        actions: [
          Icon(Icons.check_circle, color: AppColors.tertiary)
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
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        color: AppColors.secondary,
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(Icons.work_sharp, color: AppColors.tertiary),
          Icon(Icons.message_sharp, color: AppColors.tertiary),
        ],
        onTap: (index){
          final routeName = index == 0 ? 'project' : 'users';
          Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                  pageBuilder: (_,__,___) => routeName == 'project' ? ProjectPage() : UsersPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero
              )
          );
        },
      )
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

