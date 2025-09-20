import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/project_page.dart';
import 'package:chat_app/pages/users_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/navbar_service.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/app_colors.dart';

class CorePage extends StatelessWidget {

  String title;
  Widget child;
  CorePage({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final navbarService = Provider.of<NavbarService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              )
          ),
          elevation: 7,
          shadowColor: AppColors.darkBackgroundColor,
          backgroundColor: AppColors.secondary,
          actions: [
            GestureDetector(
              onTap: (){
                authService.logout();
                Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                        pageBuilder: (_,__,___) => LoginPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero
                    )
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 15),
                child: Icon(Icons.offline_bolt, color: AppColors.tertiary),
              ),
            )
          ],
        ),
        body: child,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AppColors.backgroundColor,
          color: AppColors.secondary,
          animationDuration: Duration(milliseconds: 200),
          items: [
            Icon(Icons.work_sharp, color: AppColors.backgroundColor),
            Icon(Icons.message_sharp, color: AppColors.backgroundColor)
          ],
          index: navbarService.index,
          onTap: (index){
            final routeName = index == 0 ? 'project' : 'users';
            navbarService.index = index;
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
