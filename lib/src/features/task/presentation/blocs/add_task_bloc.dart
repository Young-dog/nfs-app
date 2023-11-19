import 'dart:async';

import 'package:app/src/features/auth/presentation/widgets/text_input.dart';
import 'package:app/src/shared/domain/entities/land.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../shared/domain/entities/unit.dart';
import '../../../../shared/domain/entities/vehicle.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  AddTaskBloc() : super(AddTaskInitial()) {
    on<AddTaskEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
