import 'dart:async';
import 'dart:convert';

import 'package:app/src/shared/domain/use_cases/use_cases.dart';
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
    emit(state.copyWith(status: LoginWithNfsStatus.loading));
    try {
      var isAvailable = await NfcManager.instance.isAvailable();

      if (!isAvailable) {
        debugPrint('Nfc недоступно');
        return;
      }

      unawaited(NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {

          // final ndef = Ndef.from(tag);
          // final record = ndef?;

          final id = tag.data['isodep']['identifier'] as List<int>;
          id.join();
          print('------> ${tag.data}');

          //final decodedPayload = ascii.decode(record?.payload);
          //debugPrint(decodedPayload);
          emit(
            state.copyWith(
              status: LoginWithNfsStatus.success,
            ),
          );
        },
      ));
      await _loginWithNfs(
        const LoginWithNfsParams(rfidId: 'rfidId')
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
