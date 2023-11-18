import '../../../../shared/domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_data_source.dart';
import 'package:app/src/shared/domain/entities/user.dart' as user_entity;


class AuthRepositoryImpl extends AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Stream<AuthStatus> get status => authDataSource.status;

  @override
  Future<User> get user => authDataSource.user;

  @override
  Future<void> signInWithNfs({String? rfidId}) {

    return authDataSource.signInWithNfs(rfidId: rfidId);
  }

  @override
  Future<bool> checkUser({String? rfidId}) async {

    final check = await authDataSource.checkUser(rfidId: rfidId);

    return check;
  }

  @override
  Future<void> logout() {
    return authDataSource.logout();
  }

  @override
  Future<void> signUp({required user_entity.User user}) async {
    await authDataSource.signUp(user: user);
  }
}
