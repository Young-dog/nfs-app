
import 'dart:math';

import 'package:app/src/shared/domain/entities/land.dart';
import 'package:app/src/shared/domain/entities/user_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/land_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'add_land_state.dart';

class AddLandCubit extends Cubit<AddLandState> {

  AddLandCubit({required LandRepository landRepository})
      : _landRepository = landRepository,
        super(AddLandInitial());

  final LandRepository _landRepository;

  Future<void> addLand() async {
    print('-------> hhh');
    await _landRepository.addLand(
      const Land(
        landId: 'land_id',
        title: 'land',
        square: 100,
        coordinates: Point(100, 0),
        createdBy: UserInfo(
          id: 'user_id',
          name: 'name',
        ),
      ),
    );
  }

  //AddLandCubit(this._landRepository) : super(AddLandInitial());

}
