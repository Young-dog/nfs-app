import 'dart:async';

import 'package:app/src/shared/domain/entities/task.dart';
import 'package:app/src/shared/domain/use_cases/use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/get_tasks.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks _getTasks;

  TaskBloc({
    required GetTasks getTasks,
  })  : _getTasks = getTasks,
        super(TaskLoading()) {
    on<LoadTask>(_onLoadTask);
  }

  void _onLoadTask(LoadTask event, Emitter<TaskState> emit) async {
    try {
      var tasks = await _getTasks(NoParams());
      emit(
        TaskLoaded(
          tasks: tasks,
        ),
      );
    } catch (e, s) {
      debugPrintStack(
        label: e.toString(),
        stackTrace: s,
      );
      emit(
        TaskFailure(message: e.toString()),
      );
    }
  }
}
