import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_app/core/constants/constants.dart';
import 'package:task_app/models/task.dart';

class TaskRemoteRepository {
  Future<TaskModel> createTak({
    required String title,
    required String description,
    required String hexColor,
    required DateTime dueAt,
    required String token,
  }) async {
    try {
      final task =
          await http.post(Uri.parse("${Constants.backendUri}/tasks"), headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token
      }, body: {
        jsonEncode({
          'title': title,
          'description': description,
          'hexColor': hexColor,
          'dueAt': dueAt.toIso8601String(),
        })
      });

      if (task.statusCode != 201) {
        throw jsonDecode(task.body)['msg'];
      }

      return TaskModel.fromJson(task.body);
    } catch (error) {
      throw error.toString();
    }
  }
}
