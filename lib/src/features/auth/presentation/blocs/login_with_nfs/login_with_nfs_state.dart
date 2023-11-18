part of 'login_with_nfs_cubit.dart';

enum LoginWithNfsStatus {
  initial,
  loading,
  success,
  error,
  signUp,
}

class LoginWithNfsState extends Equatable {
  final LoginWithNfsStatus status;
  final String? errorText;
  final String? rfidId;

  const LoginWithNfsState({
    required this.status,
    this.errorText,
    this.rfidId,
  });

  factory LoginWithNfsState.initial() {
    return const LoginWithNfsState(
      status: LoginWithNfsStatus.initial,
    );
  }

  LoginWithNfsState copyWith({
    LoginWithNfsStatus? status,
    String? errorText,
    String? rfidId,
  }) {
    return LoginWithNfsState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
      rfidId: rfidId ?? this.rfidId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorText,
        rfidId,
      ];
}
