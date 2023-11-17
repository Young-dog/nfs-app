part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final User loggedInUser;
  final AuthStatus status;

  const AuthState._({
    this.status = AuthStatus.unknown,
    this.loggedInUser = User.empty,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated({required User user})
      : this._(loggedInUser: user, status: AuthStatus.authenticated);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);


  @override
  List<Object> get props => [status, loggedInUser];
}
