import 'package:formz/formz.dart';

enum RoleInputError {
  empty;
}

class RoleInput extends FormzInput<String, RoleInputError> {
  const RoleInput.pure({
    required this.isRequired,
  }) : super.pure('');

  const RoleInput.dirty({
    required this.isRequired,
    required String value,
  }) : super.dirty(value);

  RoleInput toDirty({
    required String value,
    String? serverError,
  }) {
    return RoleInput.dirty(
      isRequired: isRequired,
      value: value,
    );
  }

  final bool isRequired;

  @override
  RoleInputError? validator(String value) {
    if (isRequired) {
      return value.isEmpty ? RoleInputError.empty : null;
    } else {
      return null;
    }
  }
}
