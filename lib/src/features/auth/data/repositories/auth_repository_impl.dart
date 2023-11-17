import '../../../../shared/domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Stream<AuthStatus> get status => authDataSource.status;

  @override
  Future<User> get user => authDataSource.user;

  @override
  Future<void> signInWithNfs() {
    return authDataSource.signInWithNfs();
  }

  @override
  Future<void> logout() {
    return authDataSource.logout();
  }
}
