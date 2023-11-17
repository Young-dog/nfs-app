import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_base_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app/src/shared/domain/entities/user.dart' as user_entity;

import '../../../../shared/data/models/user_model.dart';


enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

abstract class AuthDataSource {
  Stream<AuthStatus> get status;

  Future<user_entity.User> get user;

  Future<void> signInWithGoogle();

  Future<void> logout();
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
    return Future.delayed(const Duration(milliseconds: 300), () {
      if (_firebaseAuth.currentUser != null) {
        return _firebaseFirestore
            .collection('users')
            .doc(_firebaseAuth.currentUser!.uid)
            .get()
            .then((snapshot) {
          return UserModel.fromSnapshot(snapshot).toEntity();
        });
      } else {
        return user_entity.User.empty;
      }


    });
  }

  @override
  Future<void> logout() {
    return Future.delayed(const Duration(milliseconds: 300), () {
      _firebaseAuth.signOut();
      _controller.add(AuthStatus.unauthenticated);
    });
  }

  @override
  Future<void> signInWithGoogle() async {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        try {
          // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          // final GoogleSignInAuthentication? googleAuth =
          //     await googleUser?.authentication;
          // final credential = GoogleAuthProvider.credential(
          //   accessToken: googleAuth?.accessToken,
          //   idToken: googleAuth?.idToken,
          // );
          //
          // // Once signed in, return the UserCredential
          // await _firebaseAuth.signInWithCredential(credential).then(
          //   (value) {
          //     _createUser(user: value.user!);
          //     _controller.add(AuthStatus.authenticated);
          //   },
          // );
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

  Future<void> _createUser({User? user}) async {
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
          final newUser = user_entity.User(
            id: user.uid,
            name: user.displayName ?? 'No name',
            email: user.email ?? 'No email',
            createdAt: now,
            lastModified: now,
            imageUrl: user.photoURL,
          );

          await _firebaseFirestore.collection('users').doc(newUser.id).set(
                newUser.toDocument(),
              );
        }
      });
    } catch (e) {
      throw Exception(e.toString());
    }
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