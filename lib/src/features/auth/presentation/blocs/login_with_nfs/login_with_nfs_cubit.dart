import 'dart:async';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/use_cases/login_with_nfs.dart';

part 'login_with_nfs_state.dart';

class LoginWithNfsCubit extends Cubit<LoginWithNfsState> {
  final LoginWithNfs _loginWithNfs;

  final AuthRepository _authRepository;

  LoginWithNfsCubit({
    required AuthRepository authRepository,
    required LoginWithNfs loginWithNfs,
  })
      : _loginWithNfs = loginWithNfs,
        _authRepository = authRepository,
        super(LoginWithNfsState.initial());

  void loading() {
    emit(
      state.copyWith(
        status: LoginWithNfsStatus.loading,
      ),
    );
  }

  Future<void> signInWithNfc() async {
    emit(
      state.copyWith(
        status: LoginWithNfsStatus.loading,
      ),
    );

    try {
      NfcManager.instance.stopSession();
      bool isAvailable = await NfcManager.instance.isAvailable();

      if (!isAvailable) {
        return;
      }
      var userNew = false;

      await NfcManager.instance.startSession(
          onDiscovered: (NfcTag tag) async {
            final rfidId = tag.data['nfca']['identifier'].join();

            debugPrint(rfidId);

            userNew = true;

            if (userNew) {
              emit(
                state.copyWith(
                  status: LoginWithNfsStatus.signUp,
                ),
              );
            }

            final check = await _authRepository.checkUser(rfidId: rfidId);

            if (!check) {
              emit(
                state.copyWith(
                  status: LoginWithNfsStatus.signUp,
                ),
              );
            }

            /*await _loginWithNfs(
              LoginWithNfsParams(
                rfidId: rfidId,
              ),
            );*/
            // emit(state.copyWith(status: LoginWithNfsStatus.success));
            // emit(state.copyWith(status: LoginWithNfsStatus.initial));
            }
      );

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
