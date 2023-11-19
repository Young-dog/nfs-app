import 'dart:async';
import 'dart:typed_data';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:app/src/shared/domain/entities/user.dart' as user_entity;

import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/use_cases/login_with_nfs.dart';

part 'login_with_nfs_state.dart';

class LoginWithNfsCubit extends Cubit<LoginWithNfsState> {
  final LoginWithNfs _loginWithNfs;

  final AuthRepository _authRepository;

  LoginWithNfsCubit({
    required AuthRepository authRepository,
    required LoginWithNfs loginWithNfs,
  })  : _loginWithNfs = loginWithNfs,
        _authRepository = authRepository,
        super(LoginWithNfsState.initial());

  void loading() {
    emit(
      state.copyWith(
        status: LoginWithNfsStatus.loading,
      ),
    );
  }

  Future<void> signUp({
    required String lastName,
    required String firstName,
    required String middleName,
    required String role,
  }) async {
    emit(
      state.copyWith(
        status: LoginWithNfsStatus.loading,
      ),
    );

    try {
      if (state.rfidId != null) {
        final user = user_entity.User(
          userId: state.rfidId!,
          lastName: lastName,
          firstName: firstName,
          middleName: middleName,
          employeeId: 'No employeeId',
          position: 'No position',
          role: role,
          rfidId: state.rfidId!,
        );

        await _authRepository.signUp(user: user);

        emit(state.copyWith(status: LoginWithNfsStatus.success));
        emit(state.copyWith(status: LoginWithNfsStatus.initial));
      }
    } catch (e, s) {
      debugPrintStack(
        label: '$e',
        stackTrace: s,
      );
      emit(
        state.copyWith(
          status: LoginWithNfsStatus.error,
        ),
      );
    }
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

      await NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        var nfca = tag.data['nfca'];

        if (nfca == null) {
          emit(
            state.copyWith(
              status: LoginWithNfsStatus.error,
              errorText: 'NFC-метка не найдена',
            ),
          );
          emit(state.copyWith(status: LoginWithNfsStatus.initial));
        }

        var identifier = nfca['identifier'];

        if (identifier == null) {
          emit(
            state.copyWith(
              status: LoginWithNfsStatus.error,
              errorText: 'NFC-метка не найдена',
            ),
          );
          emit(state.copyWith(status: LoginWithNfsStatus.initial));
        }

        final rfidId = tag.data['nfca']['identifier'].join();

        final check = await _authRepository.checkUser(rfidId: rfidId);

        if (!check) {
          emit(
            state.copyWith(
              status: LoginWithNfsStatus.signUp,
              rfidId: rfidId,
            ),
          );
        } else {
          await _loginWithNfs(
            LoginWithNfsParams(
              rfidId: rfidId,
            ),
          );
          emit(state.copyWith(status: LoginWithNfsStatus.success));
          emit(state.copyWith(status: LoginWithNfsStatus.initial));
        }
      });
    } catch (e, s) {
      debugPrintStack(
        label: '$e',
        stackTrace: s,
      );
      emit(
        state.copyWith(
          status: LoginWithNfsStatus.error,
          errorText: e.toString(),
        ),
      );
    }
  }
}
