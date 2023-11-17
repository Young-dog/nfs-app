import '../../../../shared/domain/use_cases/use_cases.dart';
import '../repositories/auth_repository.dart';

class SignInWithGoogle implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  SignInWithGoogle(this.authRepository);

  @override
  Future<void> call(NoParams params) {
    return authRepository.signInWithGoogle();
  }

}