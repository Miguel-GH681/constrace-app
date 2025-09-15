import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/helpers/state_mapper.dart';
import 'package:chat_app/models/status.dart';
import 'package:chat_app/models/task.dart';
import 'package:chat_app/pages/core_page.dart';
import 'package:chat_app/services/project_service.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../widgets/custom_input.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final projectService = ProjectService();
  List<Task> tasks = [];
  List<Status> status = [];
  Status? initValue;

  @override
  void initState() {
    _getTasks(ProjectService.blockConfig['block_id']);
    _getStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final mediaQuery = MediaQuery.of(context).size;

    return CorePage(
      title: 'Tareas',
      child: Column(
        children: [
          SizedBox(
            height: 220,
            child: CarouselSlider(
              items: [
                _personCard(mediaQuery)
              ],
              options: CarouselOptions(
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                viewportFraction: 1,
                padEnds: true
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 400,
            child: _taskList(mediaQuery, context),
          ),
        ],
      )
    );
  }

  Widget _taskList(Size mediaQuery, BuildContext ctx) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        height: 110,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white10,
            width: 2
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(2,4)
            )
          ]
        ),
        child: GestureDetector(
          onTap: (){
            showDialog(
              context: ctx,
              builder: (_) => StatefulBuilder(
                builder: (context, setStateDialog) => AlertDialog(
                  backgroundColor: AppColors.backgroundColor,
                  title: Text( 'Modificar Tareas'),
                  content: SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.only(top: 10, left: 5, bottom: 5, right: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: Offset(0, 5),
                                    blurRadius: 5
                                )
                              ]
                          ),
                          width: double.infinity,
                          child: DropdownButton(
                            underline: SizedBox(),
                            value: initValue,
                            icon: Icon(Icons.rule_sharp),
                            items: status.map((s){
                              return DropdownMenuItem(
                                value: s,
                                child: Text(s.name),
                              );
                            }).toList(),
                            onChanged: (value){
                              initValue = value;
                              setStateDialog(() {
                              });
                            },
                          ),
                        ),
                        CustomInput(
                          icon: Icons.mail_outline,
                          placeholder: 'Días',
                          textInputType: TextInputType.number,
                          textEditingController: TextEditingController(),
                        )
                      ],
                    ),
                  ),
                  actions: [
                    MaterialButton(
                      child: Text('Ok'),
                      elevation: 5,
                      textColor: Colors.blue,
                      onPressed: ()=> Navigator.pop(context),
                    )
                  ],
                ),
              )
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tasks[i].title,
                    style: TextStyle(
                      color: AppColors.secondary,
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
              Divider(
                height: 1,
                color: AppColors.darkBackgroundColor,
              ),
              Text(
                tasks[i].description,
                style: TextStyle(
                color: AppColors.darkBackgroundColor,
                fontSize: 16,
                ),
                textAlign: TextAlign.start,
              )
            ],
          ),
        )
      ),
      itemCount: tasks.length,
    );
  }

  Widget _personCard(Size mediaQuery) {
    return Stack(
      children: [
        Positioned(
          top: 25,
          left: 15,
          child: Container(
            height: 180,
            width: mediaQuery.width * 0.9,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 6,
                  offset: Offset(2,4)
                )
              ]
            ),
          )
        ),
        Positioned(
          top: 5,
          left: 25,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              height: 170,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.secondary,
                image: DecorationImage(
                    image: AssetImage('assets/house-icon.png'),
                  fit: BoxFit.fill
                )
              ),
            ),
          ),
        ),
        Positioned(
          top: 45,
          left: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Encargado',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'Alberto Perez',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.text70,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text('albertop@gmail.com')
            ],
          ),
        )
      ],
    );
  }

  _getTasks(String blockId) async{
    List<Task> res = await projectService.getTasks(blockId);
    if(res.isNotEmpty){
      tasks = res;
      setState(() {  });
      refreshController.refreshCompleted();
    }
  }

  _getStatus() async{
    List<Status> res = await projectService.getStatus();
    if(res.isNotEmpty){
      status = res;
    }
  }
}
