part of 'logout_cubit.dart';

enum LogoutStatus { initial, loading, success, error }

class LogoutState extends Equatable {
  final LogoutStatus status;
  final String? errorText;

  const LogoutState({
    required this.status,
    this.errorText,
  });

  factory LogoutState.initial() {
    return const LogoutState(
      status: LogoutStatus.initial,
    );
  }

  LogoutState copyWith({
    LogoutStatus? status,
    String? errorText,
  }) {
    return LogoutState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [status, errorText];
}

