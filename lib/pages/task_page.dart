import 'package:chat_app/models/task.dart';
import 'package:chat_app/services/project_service.dart';
import 'package:chat_app/theme/app_colors.dart';
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
        backgroundColor: AppColors.primary,
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
                    tasks[i].title,
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
        itemCount: tasks.length,
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
