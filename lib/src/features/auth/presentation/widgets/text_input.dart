import 'package:formz/formz.dart';

enum TextInputError {
  empty;
}

class TextInput extends FormzInput<String, TextInputError> {
  const TextInput.pure({
    required this.isRequired,
  }) : super.pure('');

  const TextInput.dirty({
    required this.isRequired,
    required String value,
  }) : super.dirty(value);

  TextInput toDirty({
    required String value,
    String? serverError,
  }) {
    return TextInput.dirty(
      isRequired: isRequired,
      value: value,
    );
  }

  final bool isRequired;

  @override
  TextInputError? validator(String value) {
    if (isRequired) {
      return value.isEmpty ? TextInputError.empty : null;
    } else {
      return null;
    }
  }
}
