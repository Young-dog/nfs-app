import 'dart:async';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';

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

      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          try {

            final rfidId = tag.data['nfca']['identifier'].join();

            debugPrint(rfidId);

            await _loginWithNfs(
              LoginWithNfsParams(
                rfidId: rfidId,
              ),
            );
            emit(state.copyWith(status: LoginWithNfsStatus.success));
            emit(state.copyWith(status: LoginWithNfsStatus.initial));
          } catch (e) {
            debugPrint('Error emitting NFC data: $e');
            emit(
              state.copyWith(
                status: LoginWithNfsStatus.error,
                errorText: e.toString(),
              ),
            );
            return;
          }
        },
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
