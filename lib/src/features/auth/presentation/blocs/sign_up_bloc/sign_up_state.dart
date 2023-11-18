part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({this.firstName, this.lastName, this.middleName});

  final TextInput? firstName;
  final TextInput? lastName;
  final String? middleName;

  @override
  List<Object?> get props => [];
}