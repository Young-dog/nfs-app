import 'package:formz/formz.dart';

import '../../../../shared/data/models/role_user.dart';

enum RoleInputError {
  empty;
}

class RoleInput extends FormzInput<RoleUser?, RoleInputError> {
  const RoleInput.pure({
    required this.isRequired,
  }) : super.pure(null);

  const RoleInput.dirty({
    required this.isRequired,
    required RoleUser? value,
  }) : super.dirty(value);

  RoleInput toDirty({
    required RoleUser? value,
    String? serverError,
  }) {
    return RoleInput.dirty(
      isRequired: isRequired,
      value: value,
    );
  }

  final bool isRequired;

  @override
  RoleInputError? validator(RoleUser? value) {
    if (isRequired) {
      return value == null ? RoleInputError.empty : null;
    } else {
      return null;
    }
  }
}
