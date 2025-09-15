import 'package:chat_app/models/contact.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/pages/core_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final userService = UserService();
  List<Contact> users = [];

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);
    return CorePage(
        title: authService.user.fullName,
        child: _userListView()
    );
  }

  Widget _userListView() {
    return GroupedListView(
      elements: users,
      groupBy: (user) => user.projectName,
      groupSeparatorBuilder: (title){
        return Container(
          padding: EdgeInsets.only(top: 5),
          width: double.infinity,
          height: 35,
          decoration: BoxDecoration(
            color: AppColors.secondary,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: AppColors.text100,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
      itemBuilder: (context, user){
        return GestureDetector(
          onTap: (){
            final chatService = Provider.of<ChatService>(context, listen: false);
            chatService.usuarioTo = User(userId: user.userId, fullName: user.fullName, phone: '', email: '', password: '', roleId: 0);
            Navigator.pushNamed(context, 'chat');
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              border: Border.all(
                  color: Colors.black.withOpacity(0.05),
                  width: 1
              )
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    user.fullName.substring(0, 2),
                    style: TextStyle(
                        color: AppColors.secondary
                    )
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.fullName),
                    SizedBox(height: 10),
                    Text(user.description),
                  ],
                )
              ],
            ),
          ),
        );
      },
      useStickyGroupSeparators: false,
      floatingHeader: true,
      order: GroupedListOrder.ASC,
    );
  }

  _cargarUsuarios() async{
    users = await userService.getUsers();
    setState(() {  });
  }
}
