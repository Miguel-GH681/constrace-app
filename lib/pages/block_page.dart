import 'dart:math' as math;

import 'package:chat_app/helpers/icon_mapper.dart';
import 'package:chat_app/models/block.dart';
import 'package:chat_app/models/statistics.dart';
import 'package:chat_app/pages/core_page.dart';
import 'package:chat_app/services/project_service.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class BlockPage extends StatefulWidget {
  const BlockPage({super.key});

  @override
  State<BlockPage> createState() => _BlockPageState();
}

class _BlockPageState extends State<BlockPage> {
  final projectService = ProjectService();
  List<Block> blocks = [];
  Statistics statistics = Statistics(totalTasks: 1, finishedTasks: 0);
  final blockConfig = ProjectService.blockConfig;

  @override
  void initState() {
    _loadProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final measure = MediaQuery.of(context).size;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, _){
        ProjectService.blockConfig = { 'project_id': blockConfig['project_id'], 'block_type_id': '1' };
      },
      child: CorePage(
        title: blockConfig['title'] ?? '',
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white10,
                    width: 2
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: Offset(2,4)
                    )
                  ]
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: measure.width * 0.22,
                      child: CircularStepProgressIndicator(
                        totalSteps: statistics.totalTasks,
                        currentStep: statistics.finishedTasks,
                        stepSize: 15,
                        selectedColor: AppColors.tertiary,
                        unselectedColor: AppColors.primary,
                        padding: math.pi / 60,
                        startingAngle: 0,
                        arcSize: math.pi * 2,
                      ),
                    ),
                    SizedBox(width: 30),
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tareas: ${statistics.totalTasks}',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            'Tareas finalizadas: ${statistics.finishedTasks}',
                            style: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30,
                    childAspectRatio: 1
                  ),
                  itemCount: blocks.length,
                  itemBuilder: (context, i){
                    return GestureDetector(
                      onTap: (){
                        if(blockConfig['block_type_id'] == '1'){
                          ProjectService.blockConfig = {
                            'project_id': blockConfig['project_id'],
                            'block_type_id': '2',
                            'parent_id': blocks[i].blockId.toString(),
                            'title': blocks[i].name
                          };
                          Navigator.pushNamed(context, 'block');
                        } else{
                          ProjectService.blockConfig = { 'block_id': blocks[i].blockId.toString() };
                          Navigator.pushNamed(context, 'task');
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(2,4)
                                )
                              ]
                          ),
                          child: blockConfig['block_type_id'] == '1'
                              ? _iconColumn(blocks[i])
                              : _graphColumn(blocks[i])
                      ),
                    );
                  }
                ),
              ),
            ],
          )
        )
      )
    );
  }

  Widget _iconColumn(Block block) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          IconMapper.getIcon(block.icon),
          size: 45, color: AppColors.secondary
        ),
        SizedBox(height: 10),
        Text(
          block.name,
          style: TextStyle(
            color: AppColors.secondary,
            fontSize: 15,
            fontWeight: FontWeight.bold
          )
        )
      ],
    );
  }

  Widget _graphColumn(Block block) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 100,
          width: 100,
          // color: Colors.red,
          child: CircularStepProgressIndicator(
            totalSteps: block.totalTasks == 0 ? 1 : block.totalTasks,
            currentStep: block.finishedTasks,
            selectedColor: AppColors.tertiary,
            unselectedColor: AppColors.primary,
            padding: math.pi / 60,
            width: 10,
            child: Icon(
              IconMapper.getIcon(block.icon),
              color: AppColors.secondary,
              size: 55,
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            block.name,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColors.secondary,
              fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }

  _loadProjects() async{
    Map<String, dynamic> queryParamsBlock = {};
    Map<String, dynamic> queryParamsStatistics = {};

    if(blockConfig['block_type_id'] == '1'){
      queryParamsBlock = {
        'project_id':blockConfig['project_id'],
        'block_type_id': blockConfig['block_type_id']
      };

      queryParamsStatistics = {
        'project_id':blockConfig['project_id'],
        'statistics_type': 'project'
      };
    } else{
      queryParamsBlock = {
        'project_id':blockConfig['project_id'],
        'block_type_id': blockConfig['block_type_id'],
        'parent_id': blockConfig['parent_id']
      };

      queryParamsStatistics = {
        'project_id':blockConfig['project_id'],
        'statistics_type': 'block',
        'block_id': blockConfig['parent_id']
      };
    }

    List<Block> res = await projectService.getBlocks(queryParamsBlock);
    statistics = await projectService.getProjectStatistics(queryParamsStatistics);
    if(res.isNotEmpty){
      blocks = res;
      setState(() {  });
    }
  }
}
