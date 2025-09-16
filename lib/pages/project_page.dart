import 'package:carousel_slider/carousel_slider.dart';
import 'package:chat_app/pages/core_page.dart';
import 'package:chat_app/widgets/card_custom_painter.dart';
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

    return CorePage(
      title: 'Proyectos',
      child: _projectListView(mediaQuery)
    );
  }

  Widget _projectListView(Size mediaQuery) {
    return Container(
      height: mediaQuery.height * 0.7,
      margin: EdgeInsets.only(top: 40),
      child: CarouselSlider(
        items: projects.map((project){
          return GestureDetector(
            onTap: (){
              ProjectService.blockConfig = {'project_id': project.projectId.toString(), 'block_type_id':'1', 'title': project.projectName};
              Navigator.pushNamed(context, 'block');
            },
            child: _carouselItem(mediaQuery, project)
          );
        }).toList(),
        options: CarouselOptions(
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          viewportFraction: 0.9,
          height: mediaQuery.height * 0.6,
          padEnds: true
        ),
      )
    );
  }

  Container _carouselItem(Size mediaQuery, Project project) {
    return Container(
      height: mediaQuery.height,
      width: mediaQuery.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 6,
              offset: Offset(2,4)
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 30,
                child: Image(image: AssetImage('assets/flag.png')),
              ),
              Positioned(
                bottom: 30,
                child: Image.asset(
                  'assets/flag.png',
                  width: mediaQuery.width * 0.36,
                ),
              ),
              Positioned(
                top: 170,
                child: Container(
                  width: mediaQuery.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        project.projectName,
                        style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 90,),
                      Text(
                        project.projectOwner,
                        style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'Lunes 30 de septiembre del 2025',
                        style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),

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
