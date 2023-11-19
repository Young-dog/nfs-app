part of 'add_task_cubit.dart';


enum AddTaskStatus { initial, loading, success, error }

class AddTaskState extends Equatable {
  final AddTaskStatus status;
  final String? errorText;

  const AddTaskState({
    required this.status,
    this.errorText,
  });

  factory AddTaskState.initial() {
    return const AddTaskState(
      status: AddTaskStatus.initial,
    );
  }

  AddTaskState copyWith({
    AddTaskStatus? status,
    String? errorText,
  }) {
    return AddTaskState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [status, errorText];
}

