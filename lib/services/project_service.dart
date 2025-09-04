import 'dart:developer';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/block.dart';
import 'package:chat_app/models/block_response.dart';
import 'package:chat_app/models/project_response.dart';
import 'package:chat_app/models/project_statistics_response.dart';
import 'package:chat_app/models/statistics.dart';
import 'package:chat_app/models/task.dart';
import 'package:chat_app/models/task_response.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

import '../models/project.dart';

class ProjectService{

  static Map<String, dynamic> blockConfig = {};

  Future<List<Project>> getProjects() async {
    final uri = Uri.http(Environment.apiUrl, '/api/project/project', {
      'user_id': '2'
    });
    final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
    );
    if( res.statusCode == 200 ){
      final loginResponse = projectResponseFromJson(res.body);
      List<Project> projects = loginResponse.msg;
      return projects;
    } else{
      return [];
    }
  }

  Future<List<Block>> getBlocks(Map<String, dynamic> queryParams) async {
    final uri = Uri.http(Environment.apiUrl, '/api/project/block', queryParams);
    final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
    );
    if( res.statusCode == 200 ){
      final loginResponse = blockResponseFromJson(res.body);
      List<Block> blocks = loginResponse.msg;
      return blocks;
    } else{
      return [];
    }
  }

  Future<List<Task>> getTasks(String blockId) async {
    final uri = Uri.http(Environment.apiUrl, '/api/project/task', {
      'block_id': blockId
    });
    final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
    );
    if( res.statusCode == 200 ){
      final loginResponse = taskResponseFromJson(res.body);
      List<Task> blocks = loginResponse.msg;
      return blocks;
    } else{
      return [];
    }
  }

  Future<Statistics> getProjectStatistics(Map<String, dynamic> queryParams) async {
    final uri = Uri.http(Environment.apiUrl, '/api/project/project-statistics', queryParams);
    final res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
    );
    if( res.statusCode == 200 ){
      final loginResponse = projectStatisticsResponseFromJson(res.body);
      Statistics statistics = loginResponse.msg;
      return statistics;
    } else{
      return Statistics(totalTasks: 1, finishedTasks: 0);
    }
  }
}