import 'dart:developer';

import 'package:chat_app/helpers/icon_mapper.dart';
import 'package:chat_app/models/block.dart';
import 'package:chat_app/services/project_service.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class BlockPage extends StatefulWidget {
  const BlockPage({super.key});

  @override
  State<BlockPage> createState() => _BlockPageState();
}

class _BlockPageState extends State<BlockPage> {
  RefreshController refreshController = RefreshController(initialRefresh: false);
  final projectService = ProjectService();
  List<Block> blocks = [];

  final blockConfig = ProjectService.blockConfig;

  @override
  void initState() {
    _loadProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (_, _){
        log('ya salio');
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Bloques',
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
        body: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          header: WaterDropHeader(
            complete: Icon(Icons.check_circle, color: AppColors.tertiary),
            waterDropColor: AppColors.tertiary,
          ),
          onRefresh: (){
            _loadProjects();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      ProjectService.blockConfig = { 'project_id': blockConfig['project_id'], 'block_type_id': '2', 'parent_id': blocks[i].blockId.toString() };
                      Navigator.pushNamed(context, 'block');
                    } else{
                      // Navigator.pushNamed(context, 'block');
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white10,
                        width: 2
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconMapper.getIcon(blocks[i].icon),
                          size: 45, color: Colors.white70
                        ),
                        SizedBox(height: 10),
                        Text(
                          blocks[i].name,
                          style: TextStyle(
                            color: AppColors.text70,
                            fontSize: 15
                          )
                        )
                      ],
                    ),
                  ),
                );
              }
            )
          )
        )
      ),
    );
  }

  _loadProjects() async{
    Map<String, dynamic> queryParams = {};
    if(blockConfig['block_type_id'] == '1'){
      queryParams = {
        'project_id':blockConfig['project_id'],
        'block_type_id': blockConfig['block_type_id']
      };
    } else{
      queryParams = {
        'project_id':blockConfig['project_id'],
        'block_type_id': blockConfig['block_type_id'],
        'parent_id': blockConfig['parent_id']
      };
    }

    List<Block> res = await projectService.getBlocks(queryParams);
    if(res.isNotEmpty){
      blocks = res;
      setState(() {  });
      refreshController.refreshCompleted();
    }
  }
}
