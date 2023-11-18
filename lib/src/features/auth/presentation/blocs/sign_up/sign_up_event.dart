part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class ChangeFirstNameEvent extends SignUpEvent {
  const ChangeFirstNameEvent({
    required this.value,
  });

  final String value;

  @override
  List<Object?> get props => [];
}

class ChangeLastNameEvent extends SignUpEvent {
  const ChangeLastNameEvent({
    required this.value,
  });

  final String value;

  @override
  List<Object?> get props => [];
}

class ChangeMiddleNameEvent extends SignUpEvent {
  const ChangeMiddleNameEvent({
    required this.value,
  });

  final String value;

  @override
  List<Object?> get props => [];
}

class ChangeRoleEvent extends SignUpEvent {
  const ChangeRoleEvent({
    required this.value,
  });

  final RoleUser? value;

  @override
  List<Object?> get props => [];
}

class SubmitEvent extends SignUpEvent {
  const SubmitEvent();
}
