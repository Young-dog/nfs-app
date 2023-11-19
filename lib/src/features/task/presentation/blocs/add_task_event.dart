part of 'add_task_bloc.dart';

abstract class AddTaskEvent extends Equatable {
  const AddTaskEvent();

  @override
  List<Object?> get props => [];
}

class ChangeTitleTaskEvent extends AddTaskEvent {
  const ChangeTitleTaskEvent({
    required this.title,
  });

  final String title;

  @override
  List<Object?> get props => [
        title,
      ];
}

class ChangeDescriptionTaskEvent extends AddTaskEvent {
  const ChangeDescriptionTaskEvent({
    required this.description,
  });

  final String description;

  @override
  List<Object?> get props => [
        description,
      ];
}

class ChangeLandTaskEvent extends AddTaskEvent {
  const ChangeLandTaskEvent({
    required this.land,
  });

  final Land land;

  @override
  List<Object?> get props => [
        land,
      ];
}

class ChangeAssignedTaskEvent extends AddTaskEvent {
  const ChangeAssignedTaskEvent({
    required this.assigned,
  });

  final UserInfo assigned;

  @override
  List<Object?> get props => [
        assigned,
      ];
}

class ChangeVehicleTaskEvent extends AddTaskEvent {
  const ChangeVehicleTaskEvent({
    required this.vehicle,
  });

  final Vehicle vehicle;

  @override
  List<Object?> get props => [
        vehicle,
      ];
}

class ChangeUnitTaskEvent extends AddTaskEvent {
  const ChangeUnitTaskEvent({
    required this.unit,
  });

  final Unit unit;

  @override
  List<Object?> get props => [
        unit,
      ];
}

class ChangeDateTaskEvent extends AddTaskEvent {
  const ChangeDateTaskEvent({
    required this.date,
  });

  final DateTime date;

  @override
  List<Object?> get props => [
        date,
      ];
}

class ChangeTimeTaskEvent extends AddTaskEvent {
  const ChangeTimeTaskEvent({
    required this.value,
  });

  final bool value;

  @override
  List<Object?> get props => [
    value,
  ];
}

class ChangePriorityTaskEvent extends AddTaskEvent {
  const ChangePriorityTaskEvent({
    required this.value,
  });

  final bool value;

  @override
  List<Object?> get props => [
    value,
  ];
}

class SubmitTaskEvent extends AddTaskEvent {
  const SubmitTaskEvent();
}