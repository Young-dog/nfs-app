import 'dart:math';

import 'package:app/src/shared/domain/entities/task.dart';
import 'package:app/src/shared/domain/entities/user_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../shared/domain/entities/user.dart';
import '../../../domain/use_cases/add_task.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final AddTask _addTask;

  AddTaskCubit({
    required AddTask addTask,
  })  : _addTask = addTask,
        super(AddTaskState.initial());

  void loading() {
    emit(
      state.copyWith(
        status: AddTaskStatus.loading,
      ),
    );
  }

  void submit({required Task taskR, required User? user}) async {
    emit(state.copyWith(status: AddTaskStatus.loading));
    try {

      var now = DateTime.now();

      final uid = Uuid().v1();


      var task = Task(
        taskId: uid,
        title: taskR.title,
        description: taskR.description,
        landId: taskR.landId,
        createdBy: UserInfo(id: '', name: ''),
        status: 'open',
        assignedTo: taskR.assignedTo,
        updatedAt: now,
        createdAt: now,
        isPriorite: taskR.isPriorite,
        isTimeTracking: taskR.isTimeTracking,
        assignedAt: now,
        closedAt: null,
      );

      await _addTask(
        AddTaskParams(
          task: task,
        ),
      );
      emit(state.copyWith(status: AddTaskStatus.success));
      emit(state.copyWith(status: AddTaskStatus.initial));

    } catch (e, s) {
      debugPrintStack(
        label: '$e',
        stackTrace: s,
      );
      emit(
        state.copyWith(
          status: AddTaskStatus.error,
          errorText: e.toString(),
        ),
      );
    }
  }
}
