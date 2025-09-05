import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/services/project_service.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/models/project.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final projectService = ProjectService();
  List<Project> projects = [];

  @override
  void initState() {
    _loadProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Proyectos',
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight:FontWeight.w500
          )
        ),
        elevation: 7,
        shadowColor: AppColors.darkBackgroundColor,
        backgroundColor: AppColors.frame,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(Icons.offline_bolt, color: AppColors.tertiary),
          )
        ],
      ),
      body: _projectListView(mediaQuery),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        color: AppColors.frame,
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(Icons.message_sharp, color: AppColors.tertiary),
          Icon(Icons.work_sharp, color: AppColors.tertiary)
        ],
      )
    );
  }

  Widget _projectListView(Size mediaQuery) {
    return Container(
      height: mediaQuery.height * 0.65,
      margin: EdgeInsets.only(top: 60, left: 45, right: 45),
      child: ListWheelScrollView(
        itemExtent: mediaQuery.height * 0.5,
        diameterRatio: 3.0,
        children: projects.map((project)=> Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                color: AppColors.primary,
                elevation: 7,
                shadowColor: AppColors.darkBackgroundColor,
                child: SizedBox(
                  height: mediaQuery.height * 0.40,
                  width: mediaQuery.width,
                  child: Column(
                    children: [
                      SizedBox(height: 150),
                      Text(
                        project.projectName,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        project.projectOwner,
                        style: TextStyle(
                            color: AppColors.text70,
                            fontSize: 20,
                        ),
                      ),
                      Text(
                        project.finalDate.toString(),
                        style: TextStyle(
                            color: AppColors.text70,
                            fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -40,
              child: SizedBox(
                height: 200,
                child: GestureDetector(
                  onTap: (){
                    ProjectService.blockConfig = {'project_id': project.projectId.toString(), 'block_type_id':'1', 'title': project.projectName};
                    Navigator.pushNamed(context, 'block');
                  },
                  child: Image.asset('assets/house-icon.png', ),
                ),
              ),
            )
          ]
        )).toList()
      ),
    );
  }

  _loadProjects() async{
    List<Project> res = await projectService.getProjects();
    if(res.isNotEmpty){
      projects = res;
      setState(() {  });
      refreshController.refreshCompleted();
    }
  }
}