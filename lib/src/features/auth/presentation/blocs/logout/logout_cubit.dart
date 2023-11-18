import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/domain/use_cases/use_cases.dart';
import '../../../domain/use_cases/logout_user.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUser _logoutUser;

  LogoutCubit({
    required LogoutUser logoutUser,
  })  : _logoutUser = logoutUser,
        super(LogoutState.initial());

  void loading() {
    emit(
      state.copyWith(
        status: LogoutStatus.loading,
      ),
    );
  }

  void submit() {
    emit(state.copyWith(status: LogoutStatus.loading));
    try {
      _logoutUser(NoParams());
      emit(state.copyWith(status: LogoutStatus.success));
      emit(state.copyWith(status: LogoutStatus.initial));
    } catch (err) {
      emit(state.copyWith(status: LogoutStatus.error, errorText: err.toString()));
    }
  }
}
