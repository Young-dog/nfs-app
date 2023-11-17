import 'package:equatable/equatable.dart';

import '../../../../shared/domain/use_cases/use_cases.dart';
import '../repositories/auth_repository.dart';

class LoginWithNfs implements UseCase<void, LoginWithNfsParams> {
  final AuthRepository authRepository;

  LoginWithNfs(this.authRepository);

  @override
  Future<void> call(LoginWithNfsParams params) {
    return authRepository.signInWithNfs(rfidId: params.rfidId);
  }
}

class LoginWithNfsParams extends Equatable {
  final String rfidId;

  const LoginWithNfsParams({required this.rfidId});
  @override
  List<Object?> get props => [rfidId];
}