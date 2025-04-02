import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/services/sp_services.dart';
import 'package:task_app/features/home/repository/task_remote_repository.dart';
import 'package:task_app/features/utils/hexToString.dart';
import 'package:task_app/models/task.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeIntial());

  final taskRemoteRepository = TaskRemoteRepository();
  final spServices = SpService();

  void createTask({
    required String title,
    required String description,
    required Color color,
    required DateTime dueAt,
  }) async {
    try {
      emit(HomeLoading());
      String? token = await spServices.getToken();

      token ??=
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAyOWNkYWZjLWQ0MWEtNDQzZC05NjdmLTgzNzU3MDMxZGZlNSIsImlhdCI6MTc0MzM5OTYyM30.DVxIDfBKMmFkGLApjDQ_31LjKTQhaLSIulO8uY0klZI";

      final taskModel = await taskRemoteRepository.createTask(
          title: title,
          description: description,
          hexColor: rgbToHex(color),
          dueAt: dueAt,
          token: token);

      emit(HomeSuccess(taskModel));
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }


  void getTasks() async {
    try {
      emit(HomeLoading());
      String? token = await spServices.getToken();

      token ??=
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjAyOWNkYWZjLWQ0MWEtNDQzZC05NjdmLTgzNzU3MDMxZGZlNSIsImlhdCI6MTc0MzM5OTYyM30.DVxIDfBKMmFkGLApjDQ_31LjKTQhaLSIulO8uY0klZI";

      List<TaskModel> list = await taskRemoteRepository.getTasks(token: token);
      //print(list);
      emit(HomeGetTask(list));
    } catch (error) {
      emit(HomeError(error.toString()));
    }
  }
}
