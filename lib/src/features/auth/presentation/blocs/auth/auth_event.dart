part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthGetStatus extends AuthEvent {
  final AuthStatus status;

  const AuthGetStatus(this.status);
  @override
  List<Object?> get props => [status];
}


class AuthLogoutUser extends AuthEvent {
  @override
  List<Object?> get props => [];
}

