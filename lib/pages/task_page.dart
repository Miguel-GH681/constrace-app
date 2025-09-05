import 'package:chat_app/helpers/state_mapper.dart';
import 'package:chat_app/models/task.dart';
import 'package:chat_app/services/project_service.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final projectService = ProjectService();
  List<Task> tasks = [];

  @override
  void initState() {
    _loadProjects(ProjectService.blockConfig['block_id']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tareas',
          style: TextStyle(
            color: Colors.white,
            fontWeight:FontWeight.w500
          )
        ),
        elevation: 0,
        backgroundColor: AppColors.frame,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Icon(Icons.offline_bolt, color: AppColors.tertiary),
          )
        ],
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, i) => Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                ),
                child: Image.network(
                  'https://adstudioshahalam.com/wp-content/uploads/2022/07/corporate-profile-headshot-business-photo-studio-1.jpg',
                ),
              ),
              SizedBox(width: 15),
              SizedBox(
                width: mediaQuery.width * 0.64,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tasks[i].title,
                          style: TextStyle(
                            color: AppColors.text70,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          )
                        ),
                        Icon(
                          Icons.circle,
                          color: StateMapper.getColor(tasks[i].status),
                          size: 22
                        ),
                      ],
                    ),
                    // Divider(
                    //   height: 1,
                    //   color: AppColors.text10,
                    // ),
                    Text(
                      tasks[i].description,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
              ),
            ],
          )
        ),
        itemCount: tasks.length,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.primary,
        color: AppColors.frame,
        animationDuration: Duration(milliseconds: 200),
        items: [
          Icon(Icons.message_sharp, color: AppColors.tertiary),
          Icon(Icons.work_sharp, color: AppColors.tertiary)
        ],
      )
    );
  }

  _loadProjects(String blockId) async{
    List<Task> res = await projectService.getTasks(blockId);
    if(res.isNotEmpty){
      tasks = res;
      setState(() {  });
      refreshController.refreshCompleted();
    }
  }
}
