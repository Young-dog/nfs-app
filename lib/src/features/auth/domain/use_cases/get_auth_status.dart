import '../../../../shared/domain/use_cases/use_cases.dart';
import '../../data/data_sources/auth_data_source.dart';
import '../repositories/auth_repository.dart';

class GetAuthStatus implements UseCase<AuthStatus, NoParams> {
  final AuthRepository authRepository;

  GetAuthStatus(this.authRepository);

  @override
  Stream<AuthStatus> call(NoParams params) {
    return authRepository.status;
  }
}

