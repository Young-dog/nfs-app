import 'dart:math';

import 'package:app/src/shared/domain/entities/land.dart';
import 'package:app/src/shared/domain/entities/user_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/use_cases/add_land.dart';

part 'add_land_state.dart';

class AddLandCubit extends Cubit<AddLandState> {
  final AddLand _addLand;

  AddLandCubit({
    required AddLand addLand,
  })  : _addLand = addLand,
        super(AddLandState.initial());

  void loading() {
    emit(
      state.copyWith(
        status: AddLandStatus.loading,
      ),
    );
  }

  void submit() async {
    emit(state.copyWith(status: AddLandStatus.loading));
    try {
      var land = const Land(
        landId: 'landId_1',
        title: 'land',
        square: 100,
        coordinates: [],
        createdBy: UserInfo(
          id: 'userId_1',
          name: 'name',
        ),
      );

      await _addLand(
        AddLandParams(
          land: land,
        ),
      );
      emit(state.copyWith(status: AddLandStatus.success));
      emit(state.copyWith(status: AddLandStatus.initial));
    } catch (e, s) {
      debugPrintStack(
        label: '$e',
        stackTrace: s,
      );
      emit(
        state.copyWith(
          status: AddLandStatus.error,
          errorText: e.toString(),
        ),
      );
    }
  }
}
