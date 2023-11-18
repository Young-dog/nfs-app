part of 'sign_up_bloc.dart';

enum SignUpStatus {
  initial,
  submitted,
  check,
  failure;

  bool get isInitial => this == initial;

  bool get isSubmitted => this == submitted;

  bool get isFailure => this == failure;
}

class SignUpState extends Equatable with FormzMixin {
  const SignUpState({
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.role,
  });

  const SignUpState.initial()
      : status = SignUpStatus.initial,
        firstName = const TextInput.pure(isRequired: true),
        lastName = const TextInput.pure(isRequired: true),
        middleName = '',
        role = const RoleInput.pure(isRequired: true);

  final SignUpStatus status;
  final TextInput firstName;
  final TextInput lastName;
  final String middleName;
  final RoleInput role;

  SignUpState copyWith({
    SignUpStatus? status,
    TextInput? firstName,
    TextInput? lastName,
    String? middleName,
    RoleInput? role,
  }) {
    return SignUpState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [
        status,
        firstName,
        lastName,
        middleName,
        role,
      ];

  @override
  List<FormzInput> get inputs => [
        firstName,
        lastName,
        role,
      ];
}
