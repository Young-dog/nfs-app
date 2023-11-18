import 'dart:async';

import 'package:app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../../../../shared/data/models/role_user.dart';
import '../../widgets/widgets.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc()  :
        super(const SignUpState.initial()) {
    on<ChangeFirstNameEvent>(_onChangeName);
    on<ChangeLastNameEvent>(_onChangeLastName);
    on<ChangeMiddleNameEvent>(_onChangeMiddleName);
    on<ChangeRoleEvent>(_onChangeRole);
    on<SubmitEvent>(_onSubmit);
  }

  void _onChangeName(
    ChangeFirstNameEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        firstName: TextInput.dirty(
          isRequired: true,
          value: event.value,
        ),
      ),
    );
  }

  void _onChangeLastName(
    ChangeLastNameEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        lastName: TextInput.dirty(
          isRequired: true,
          value: event.value,
        ),
      ),
    );
  }

  void _onChangeMiddleName(
    ChangeMiddleNameEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        middleName: event.value,
      ),
    );
  }

  void _onChangeRole(
    ChangeRoleEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        role: RoleInput.dirty(
          isRequired: true,
          value: event.value,
        ),
      ),
    );
  }

  void _onSubmit(
    SubmitEvent event,
    Emitter<SignUpState> emit,
  ) {
    emit(
      state.copyWith(
        status: SignUpStatus.check,
      ),
    );
    if (state.isNotValid) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SignUpStatus.submitted,
      ),
    );
  }
}
