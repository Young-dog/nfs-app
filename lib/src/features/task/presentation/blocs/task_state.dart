part of 'task_bloc.dart';

enum TaskStatus {
  initial,
  submitted,
  failure;

  bool get isInitial => this == initial;

  bool get isSubmitted => this == submitted;

  bool get isFailure => this == failure;
}

class TaskState extends Equatable with FormzMixin{
  const TaskState({
    required this.statusTask,
    required this.title,
    required this.description,
    required this.landId,
    required this.assignedTo,
    required this.status,
    required this.vehicle,
    required this.unit,
    required this.date,
    required this.time,
    required this.priority,
  });

  TaskState.initial({
    this.assignedTo,
    this.vehicle,
    this.unit,
  })  : statusTask = TaskStatus.initial,
        title = const TextInput.pure(isRequired: true),
        description = const TextInput.pure(isRequired: true),
        landId = TextInput.pure(isRequired: true),
        status = 'Открыта',
        date = DateTimeInput.pure(isRequired: true),
        time = false,
        priority = false;

  final TaskStatus statusTask;
  final TextInput title;
  final TextInput description;
  final TextInput landId;
  final UserInfo? assignedTo;
  final String status;
  final Vehicle? vehicle;
  final Unit? unit;
  final DateTimeInput date;
  final bool time;
  final bool priority;

  TaskState copyWith({
    TaskStatus? statusTask,
    TextInput? title,
    TextInput? description,
    TextInput? landId,
    UserInfo? assignedTo,
    String? status,
    Vehicle? vehicle,
    Unit? unit,
    DateTimeInput? date,
    bool? time,
    bool? priority,
  }) {
    return TaskState(
      statusTask: statusTask ?? this.statusTask,
      title: title ?? this.title,
      description: description ?? this.description,
      landId: landId ?? this.landId,
      assignedTo: assignedTo ?? this.assignedTo,
      status: status ?? this.status,
      vehicle: vehicle ?? this.vehicle,
      unit: unit ?? this.unit,
      date: date ?? this.date,
      time: time ?? this.time,
      priority: priority ?? this.priority,
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        landId,
        assignedTo,
        status,
        vehicle,
        unit,
        date,
        time,
        priority,
        statusTask,
      ];

  @override
  List<FormzInput> get inputs => [
    title,
    description,
    date,
  ];
}
