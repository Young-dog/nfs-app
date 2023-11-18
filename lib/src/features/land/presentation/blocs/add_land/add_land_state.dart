part of 'add_land_cubit.dart';


enum AddLandStatus { initial, loading, success, error }

class AddLandState extends Equatable {
  final AddLandStatus status;
  final String? errorText;

  const AddLandState({
    required this.status,
    this.errorText,
  });

  factory AddLandState.initial() {
    return const AddLandState(
      status: AddLandStatus.initial,
    );
  }

  AddLandState copyWith({
    AddLandStatus? status,
    String? errorText,
  }) {
    return AddLandState(
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [status, errorText];
}

