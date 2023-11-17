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

      var fnsId = await _loginWithNfs(NoParams());

      // TODO: проверить есть ли в базе данных пользвоатель с таким id. Если есть, то меняем статус на авторизован.

      // TODO: Если нет, то вызываем анонимную авторизацию (firebase) и создаем нового пользователя с полученным id


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
