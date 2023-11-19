part of 'add_task_bloc.dart';

class AddTaskState extends Equatable {
  const AddTaskState({
    required this.title,
    required this.description,
    required this.landId,
    required this.createdBy,
    required this.assignedTo,
    required this.status,
    required this.vehicle,
    required this.unit,
    required this.createdAt,
    required this.updatedAt,
  });

  AddTaskState.initial() :
        title = const TextInput.pure(isRequired: true),
        description = const TextInput.pure(isRequired: true),
        landId = TextInput.pure(isRequired: true),
        createdBy,
        assignedTo,
        status,
        vehicle,
        unit,
        createdAt,
        updatedAt;

  final TextInput title;
  final TextInput description;
  final TextInput landId;
  final UserInfo createdBy;
  final UserInfo? assignedTo;
  final TextInput status;
  final Vehicle? vehicle;
  final Unit? unit;
  final DateTimeInput date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props => [
        title,
        description,
        landId,
        createdBy,
        assignedTo,
        status,
        vehicle,
        unit,
        createdAt,
        updatedAt,
      ];
}
