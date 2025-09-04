import 'package:chat_app/pages/task_page.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/pages/block_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/pages/loading_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/users_page.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/project_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'users': ( _ ) => UsersPage(),
  'chat': ( _ ) => ChatPage(),
  'login': ( _ ) => LoginPage(),
  'register': ( _ ) => RegisterPage(),
  'loading': ( _ ) => LoadingPage(),
  'block': (_) => BlockPage(),
  'project': (_) => ProjectPage(),
  'task': (_)=> TaskPage()
};