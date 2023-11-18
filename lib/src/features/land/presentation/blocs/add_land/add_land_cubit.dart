import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_land_state.dart';

class AddLandCubit extends Cubit<AddLandState> {
  AddLandCubit() : super(AddLandInitial());
}
