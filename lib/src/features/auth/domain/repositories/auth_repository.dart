import '../../../../shared/domain/entities/user.dart';
import '../../data/data_sources/auth_data_source.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;

  Future<User> get user;

  Future<void> signInWithNfs({String? rfidId});

  Future<void> logout();

  Future<bool> checkUser({String? rfidId});
}
