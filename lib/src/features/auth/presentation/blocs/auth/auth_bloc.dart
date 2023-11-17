import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/entities/user.dart';
import '../../../../../shared/domain/use_cases/use_cases.dart';
import '../../../data/data_sources/auth_data_source.dart';
import '../../../domain/use_cases/get_auth_status.dart';
import '../../../domain/use_cases/get_auth_user.dart';
import '../../../domain/use_cases/logout_user.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late StreamSubscription<AuthStatus> _authStreamSubscription;
  final GetAuthStatus _getAuthStatus;
  final GetAuthUser _getAuthUser;
  final LogoutUser _logoutUser;

  AuthBloc({
    required GetAuthStatus getAuthStatus,
    required GetAuthUser getAuthUser,
    required LogoutUser logoutUser,
  })  : _getAuthStatus = getAuthStatus,
        _getAuthUser = getAuthUser,
        _logoutUser = logoutUser,
        super(const AuthState.unknown()) {
    on<AuthGetStatus>(_onAuthGetStatus);
    on<AuthLogoutUser>(_onAuthLogoutUser);

    _authStreamSubscription = _getAuthStatus(NoParams()).listen((status) {
      add(AuthGetStatus(status));
    });
  }

  FutureOr<void> _onAuthGetStatus(
      AuthGetStatus event,
      Emitter<AuthState> emit,
      ) async {
    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.unknown:
        return emit(const AuthState.unknown());
      case AuthStatus.authenticated:
        final user = await _getAuthUser(NoParams());
        return emit(
          AuthState.authenticated(user: user),
        );
    }
  }

  FutureOr<void> _onAuthLogoutUser(
      AuthLogoutUser event,
      Emitter<AuthState> emit,
      ) async {
    debugPrint('Start user logout with _onAuthLogoutUser');
    await _logoutUser.call(NoParams());
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    return super.close();
  }
}
