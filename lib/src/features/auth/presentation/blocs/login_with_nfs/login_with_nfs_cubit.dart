import 'dart:async';
import 'dart:convert';

import 'package:app/src/shared/domain/use_cases/use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

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

    var availability = await FlutterNfcKit.nfcAvailability;
    if (availability != NFCAvailability.available) {
      debugPrint('Nfc недоступно');
      return;
    }


    emit(state.copyWith(status: LoginWithNfsStatus.loading));
    try {

      await FlutterNfcKit.finish();

      var tag = await FlutterNfcKit.poll(
          timeout: Duration(seconds: 50),
          iosMultipleTagMessage: "Multiple tags found!",
          iosAlertMessage: "Scan your tag");

      print(tag);


      if (tag.ndefAvailable!) {
        var result = await FlutterNfcKit.readNDEFRecords(cached: false);
        var record = result.isEmpty ? null : result.first;
        String zoneId = record.toString().split("=").last;
        var selectedZoneId = zoneId;

        print(selectedZoneId);
      }

      await FlutterNfcKit.finish();

      await _loginWithNfs(NoParams());
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
