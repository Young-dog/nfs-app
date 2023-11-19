part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class ChangeTitleTaskEvent extends TaskEvent {
  const ChangeTitleTaskEvent({
    required this.title,
  });

  final String title;

  @override
  List<Object?> get props => [
        title,
      ];
}

class ChangeDescriptionTaskEvent extends TaskEvent {
  const ChangeDescriptionTaskEvent({
    required this.description,
  });

  final String description;

  @override
  List<Object?> get props => [
        description,
      ];
}

class ChangeLandTaskEvent extends TaskEvent {
  const ChangeLandTaskEvent({
    required this.land,
  });

  final Land land;

  @override
  List<Object?> get props => [
        land,
      ];
}

class ChangeAssignedTaskEvent extends TaskEvent {
  const ChangeAssignedTaskEvent({
    required this.assigned,
  });

  final UserInfo assigned;

  @override
  List<Object?> get props => [
        assigned,
      ];
}

class ChangeVehicleTaskEvent extends TaskEvent {
  const ChangeVehicleTaskEvent({
    required this.vehicle,
  });

  final Vehicle vehicle;

  @override
  List<Object?> get props => [
        vehicle,
      ];
}

class ChangeUnitTaskEvent extends TaskEvent {
  const ChangeUnitTaskEvent({
    required this.unit,
  });

  final Unit unit;

  @override
  List<Object?> get props => [
        unit,
      ];
}

class ChangeDateTaskEvent extends TaskEvent {
  const ChangeDateTaskEvent({
    required this.date,
  });

  final DateTime date;

  @override
  List<Object?> get props => [
        date,
      ];
}

class ChangeTimeTaskEvent extends TaskEvent {
  const ChangeTimeTaskEvent({
    required this.value,
  });

  final bool value;

  @override
  List<Object?> get props => [
    value,
  ];
}

class ChangePriorityTaskEvent extends TaskEvent {
  const ChangePriorityTaskEvent({
    required this.value,
  });

  final bool value;

  @override
  List<Object?> get props => [
    value,
  ];
}

class SubmitTaskEvent extends TaskEvent {
  const SubmitTaskEvent();
}