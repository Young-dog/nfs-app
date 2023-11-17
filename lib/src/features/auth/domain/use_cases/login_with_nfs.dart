import '../../../../shared/domain/use_cases/use_cases.dart';
import '../repositories/auth_repository.dart';

class LoginWithNfs implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  LoginWithNfs(this.authRepository);

  @override
  Future<void> call(NoParams params) {
    return authRepository.signInWithGoogle();
  }
}