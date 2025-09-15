import 'package:chat_app/pages/project_page.dart';
import 'package:chat_app/pages/users_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CorePage extends StatelessWidget {

  String title;
  Widget child;
  CorePage({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight:FontWeight.w500
              )
          ),
          elevation: 7,
          shadowColor: AppColors.darkBackgroundColor,
          backgroundColor: AppColors.secondary,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(Icons.offline_bolt, color: AppColors.tertiary),
            )
          ],
        ),
        body: child,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AppColors.backgroundColor,
          color: AppColors.secondary,
          animationDuration: Duration(milliseconds: 200),
          items: [
            Icon(Icons.message_sharp, color: AppColors.tertiary),
            Icon(Icons.work_sharp, color: AppColors.tertiary)
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
}
