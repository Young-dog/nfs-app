import 'package:formz/formz.dart';

enum DateTimeValidationError {
  empty;

  String toText() {
    switch (this) {
      case DateTimeValidationError.empty:
        return 'Заполните поле';
    }
  }
}

class DateTimeInput extends FormzInput<DateTime?, DateTimeValidationError> {
  const DateTimeInput.pure({
    required this.isRequired,
  }) : super.pure(null);

  const DateTimeInput.dirty({
    required this.isRequired,
    required DateTime? value,
  }) : super.dirty(value);

  final bool isRequired;

  @override
  DateTimeValidationError? validator(DateTime? value) {
    if (isRequired) {
      return value != null ? null : DateTimeValidationError.empty;
    } else {
      return null;
    }
  }
}
