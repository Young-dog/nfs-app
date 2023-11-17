part of 'login_with_nfs_cubit.dart';

enum LoginWithNfsStatus { initial, loading, success, error }

class LoginWithNfsState extends Equatable {
  final LoginWithNfsStatus status;
  final String? errorText;

  const LoginWithNfsState({
    required this.status,
    this.errorText,
  });

  factory LoginWithNfsState.initial() {
    return const LoginWithNfsState(
      status: LoginWithNfsStatus.initial,
    );
  }

  LoginWithNfsState copyWith({
    LoginWithNfsStatus? status,
    String? errorText,
  }) {
    return LoginWithNfsState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [status, errorText];
}
