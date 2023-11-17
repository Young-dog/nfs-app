import 'package:app/src/shared/domain/use_cases/use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/login_with_nfs.dart';

part 'login_with_nfs_state.dart';


class LoginWithNfsCubit extends Cubit<LoginWithNfsState> {
  final LoginWithNfs _loginWithNfs;

  LoginWithNfsCubit({
    required LoginWithNfs loginWithNfs,
  })  : _loginWithNfs = loginWithNfs,
        super(LoginWithNfsState.initial());

  void loading() {
    emit(
      state.copyWith(
        status: LoginWithNfsStatus.loading,
      ),
    );
  }

  void signInWithNfs() async {
    emit(state.copyWith(status: LoginWithNfsStatus.loading));
    try {

      // TODO: get fnsId

      await _loginWithNfs(
        const LoginWithNfsParams(rfidId: 'rfidId')
      );

      emit(state.copyWith(status: LoginWithNfsStatus.success));
      emit(state.copyWith(status: LoginWithNfsStatus.initial));
    } catch (err) {
      emit(
        state.copyWith(
          status: LoginWithNfsStatus.error,
          errorText: err.toString(),
        ),
      );
    }
  }
}
