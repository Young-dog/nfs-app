part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
}

class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoading extends TaskState {
  @override
  List<Object> get props => [];
}

class TaskLoaded extends TaskState {
  final List<Task> tasks;

  const TaskLoaded({this.tasks = const <Task>[]});
  @override
  List<Object> get props => [tasks];
}

class TaskFailure extends TaskState {
  final String message;

  const TaskFailure({required this.message});
  @override
  List<Object> get props => [message];
}
