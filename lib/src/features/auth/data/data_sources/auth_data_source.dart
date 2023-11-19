import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_base_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/src/shared/domain/entities/user.dart' as user_entity;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/data/models/user_model.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

abstract class AuthDataSource {
  Stream<AuthStatus> get status;

  Future<user_entity.User> get user;

  Future<void> signInWithNfs({String? rfidId});

  Future<void> logout();

  Future<void> signUp({required user_entity.User user});

  Future<bool> checkUser({String? rfidId});
}

class AuthDataSourceImpl extends AuthDataSource {
  final _controller = StreamController<AuthStatus>();
  final _firebaseAuth = fire_base_auth.FirebaseAuth.instance;
  final _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<AuthStatus> get status async* {
    if (_firebaseAuth.currentUser != null) {
      yield AuthStatus.authenticated;
      yield* _controller.stream;
    }
    yield AuthStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<user_entity.User> get user {
    return Future.delayed(const Duration(milliseconds: 300), () async {
      var rfid = await getRfid();

      if (rfid != '') {
        var loggedInUser = _firebaseFirestore
            .collection('users')
            .doc(rfid)
            .get()
            .then((snapshot) {
          return UserModel.fromSnapshot(snapshot).toEntity();
        });

        return loggedInUser;
      } else {
        return user_entity.User.empty;
      }
    });
  }

  @override
  Future<void> logout() {
    return Future.delayed(const Duration(milliseconds: 300), () async {
      try {
        await _firebaseAuth.signOut();
        _controller.add(AuthStatus.unauthenticated);
      } catch (e, st) {
        debugPrintStack(
          label: '$e',
          stackTrace: st,
        );
        throw Exception('$e');
      }
    });
  }

  @override
  Future<void> signInWithNfs({String? rfidId}) async {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        try {
          // Once signed in, return the UserCredential
          await _firebaseAuth.signInAnonymously().then(
            (value) {
              _createUser(user: value.user!, rfidId: rfidId);
              _controller.add(AuthStatus.authenticated);
            },
          );
          return;
        } on fire_base_auth.FirebaseAuthException catch (e) {
          throw SignupFailure.fromCode(e.code);
        } catch (error) {
          debugPrint('----> ${error.toString()}');
          throw const SignupFailure('unknown-exception');
        }
      },
    );
  }

  @override
  Future<bool> checkUser({String? rfidId}) async {

    final doc = await _firebaseFirestore
        .collection('users')
        .where(
          'rfidId',
          isEqualTo: rfidId,
        )
        .get();

    print('--------> ${doc.docs}');

    return doc.docs.isNotEmpty;
  }

  Future<void> _createUser({User? user, String? rfidId}) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(user!.uid)
          .get()
          .then((doc) async {
        if (doc.exists) {
          return;
        } else {
          var now = DateTime.now();

          await saveRfid(rfidId!);

          final newUser = user_entity.User(
            userId: rfidId,
            lastName: 'No lastName',
            firstName: user.displayName ?? 'No name',
            middleName: 'No middleName',
            employeeId: 'No employeeId',
            position: 'No position',
            role: 'агроном',
            rfidId: rfidId,
          );

          await _firebaseFirestore.collection('users').doc(newUser.userId).set(
                newUser.toDocument(),
              );
        }
      });
    } catch (e, st) {
      debugPrintStack(
        label: e.toString(),
        stackTrace: st,
      );
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signUp({required user_entity.User user}) async {

    try {
      await _firebaseAuth.signInAnonymously().then(
            (value) async {
              await _firebaseFirestore.collection('users').doc(user.userId).set(
                user.toDocument(),
              );
          _controller.add(AuthStatus.authenticated);
        },
      );

    } catch (e, st) {
      debugPrintStack(
        label: e.toString(),
        stackTrace: st,
      );
      throw Exception(e.toString());
    }
  }

  Future<String> getRfid() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cachedRfid = sharedPreferences.getString("RFID");
    debugPrint('cachedRfid= $cachedRfid');
    return cachedRfid ?? '';
  }

  Future<void> saveRfid(String rfid) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("RFID", rfid);
  }
}

class LoginWithUsernameAndPasswordFailure implements Exception {
  const LoginWithUsernameAndPasswordFailure(this.message);

  final String message;

  factory LoginWithUsernameAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'user-not-found':
        return const LoginWithUsernameAndPasswordFailure(
            'No user found with this email.');
      case 'user-disabled':
        return const LoginWithUsernameAndPasswordFailure('User disabled.');
      case 'operation-not-allowed':
        return const LoginWithUsernameAndPasswordFailure(
            'Too many requests to log into this account.');
      case 'wrong-password':
        return const LoginWithUsernameAndPasswordFailure(
            'Wrong email/password combination.');
      case 'email-already-in-use':
        return const LoginWithUsernameAndPasswordFailure(
            'Email already used. Go to login page.');
      default:
        return const LoginWithUsernameAndPasswordFailure(
            'An unknown exception occurred.');
    }
  }
}

class SignupFailure implements Exception {
  const SignupFailure(this.message);

  final String message;

  factory SignupFailure.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const SignupFailure('Email already used. Go to login page.');
      default:
        return const SignupFailure('An unknown exception occurred.');
    }
  }
}
