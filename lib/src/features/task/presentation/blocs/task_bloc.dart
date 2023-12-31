import 'dart:async';

import 'package:app/src/features/auth/presentation/widgets/text_input.dart';
import 'package:app/src/shared/domain/entities/land.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';

import '../../../../shared/domain/entities/unit.dart';
import '../../../../shared/domain/entities/vehicle.dart';
import '../../../../shared/widgets/date_time_input.dart';

part 'task_event.dart';

part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState.initial()) {
    on<ChangeTitleTaskEvent>(_onChangeTitle);
    on<ChangeDescriptionTaskEvent>(_onChangeDescription);
    on<ChangeLandTaskEvent>(_onChangeLand);
    on<ChangeAssignedTaskEvent>(_onChangeAssigned);
    on<ChangeVehicleTaskEvent>(_onChangeVehicle);
    on<ChangeUnitTaskEvent>(_onChangeUnit);
    on<ChangeDateTaskEvent>(_onChangeDate);
    on<ChangeTimeTaskEvent>(_onChangeTime);
    on<ChangePriorityTaskEvent>(_onChangePriority);
    on<SubmitTaskEvent>(_onSubmitted);
  }

  void _onChangeTitle(
    ChangeTitleTaskEvent event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      title: TextInput.dirty(
        isRequired: true,
        value: event.title,
      ),
    ));
  }

  void _onChangeDescription(
    ChangeDescriptionTaskEvent event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      description: TextInput.dirty(
        isRequired: true,
        value: event.description,
      ),
    ));
  }

  void _onChangeLand(
    ChangeLandTaskEvent event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      landId: TextInput.dirty(
        isRequired: true,
        value: event.land.landId,
      ),
    ));
  }

  void _onChangeAssigned(
    ChangeAssignedTaskEvent event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      assignedTo: event.assigned,
    ));
  }

  void _onChangeVehicle(
    ChangeVehicleTaskEvent event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      vehicle: event.vehicle,
    ));
  }

  void _onChangeUnit(
    ChangeUnitTaskEvent event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      unit: event.unit,
    ));
  }

  void _onChangeDate(
    ChangeDateTaskEvent event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      date: DateTimeInput.dirty(
        isRequired: true,
        value: event.date,
      ),
    ));
  }

  void _onChangeTime(
    ChangeTimeTaskEvent event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      time: event.value,
    ));
  }

  void _onChangePriority(
    ChangePriorityTaskEvent event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      priority: event.value,
    ));
  }

  void _onSubmitted(
    SubmitTaskEvent event,
    Emitter<TaskState> emit,
  ) {
    emit(state.copyWith(
      statusTask: TaskStatus.initial,
    ));

    if (state.isNotValid) {
      emit(state.copyWith(
        statusTask: TaskStatus.failure,
      ));
      return;
    }

    emit(state.copyWith(
      statusTask: TaskStatus.submitted,
    ));
  }
}
