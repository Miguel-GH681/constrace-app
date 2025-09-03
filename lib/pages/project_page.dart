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
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(
          'Proyectos',
          style: TextStyle(
            color: AppColors.primaryText,
            fontWeight:FontWeight.w500
          )
        ),
        elevation: 0,
        backgroundColor: AppColors.primary,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(Icons.offline_bolt, color: AppColors.tertiary),
          )
        ],
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check_circle,
            color: AppColors.tertiary
          ),
          waterDropColor: AppColors.tertiary,
        ),
        onRefresh: _loadProjects,
        child: _projectListView()
      )
    );
  }

  ListView _projectListView() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => GestureDetector(
        onTap: (){
          ProjectService.blockConfig = {'project_id':'3', 'block_type_id':'1'};
          Navigator.pushNamed(context, 'block');
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.white10,
              width: 2
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.circle_outlined, color: AppColors.tertiary, size: 40,),
                  Text(
                    projects[i].projectName,
                    style: TextStyle(
                      color: AppColors.text70,
                      fontSize: 20
                    )
                  )
                ],
              ),
              Divider(
                height: 1,
                color: AppColors.text10,
              ),
              Text(
                '21 de agosto del 2025',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20
                )
              )
            ],
          ),
        ),
      ),
      itemCount: projects.length,
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
