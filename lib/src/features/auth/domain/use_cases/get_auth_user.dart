import '../../../../shared/domain/entities/user.dart';
import '../../../../shared/domain/use_cases/use_cases.dart';
import '../repositories/auth_repository.dart';

class GetAuthUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;

  GetAuthUser(this.authRepository);

  @override
  Future<User> call(NoParams params) {
    return authRepository.user;
  }
}

