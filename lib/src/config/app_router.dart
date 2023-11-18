import 'dart:async';

import 'package:app/src/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:app/src/features/land/presentation/screens/land_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/app/presentation/screens/app_core_screen.dart';
import '../features/auth/data/data_sources/auth_data_source.dart';
import '../features/auth/presentation/blocs/auth/auth_bloc.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/issue/presentation/screens/issue_list_screen.dart';
import '../features/task/presentation/screens/task_list_screen.dart';
import '../features/user/presentation/screens/profile_screen.dart';


class AppRouter {
  final AuthBloc authBloc;

  AppRouter(this.authBloc);


  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _signUpNavigatorKey =
  GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    initialLocation: '/login',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return customTransitionPage<void>(
            context: context,
            state: state,
            child: const LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return customTransitionPage<void>(
            context: context,
            state: state,
            child: const SignUpScreen(),
          );
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppCoreScreen(
            location: state.matchedLocation,
            child: child,
          );
        },
        routes: [
          GoRoute(
              path: "/",
              name: "home",
              pageBuilder: (BuildContext context, GoRouterState state) {
                return customTransitionPage<void>(
                  context: context,
                  state: state,
                  child: const LandListScreen(),
                );
              },
          ),
          GoRoute(
            path: "/tasks",
            name: "tasks",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const TaskListScreen(),
              );
            },
          ),
          GoRoute(
            path: "/issues",
            name: "issues",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const IssueListScreen(),
              );
            },
          ),
          GoRoute(
            path: "/profile",
            name: "profile",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const ProfileScreen(),
              );
            },
          ),
        ],
      ),
    ],
    redirect: (
        BuildContext context,
        GoRouterState state,
        ) async {

      final loginLocation = state.namedLocation('login');
      final signUpLocation = state.namedLocation('signup');

      final bool isLoggedIn = authBloc.state.status == AuthStatus.authenticated;

      final onLoginScreen = state.matchedLocation == loginLocation;
      final onSignUpScreen = state.matchedLocation == signUpLocation;

      if (!isLoggedIn && !onLoginScreen && !onSignUpScreen) {
        return '/login';
      } else  if (onSignUpScreen) {
        return '/signup';
      }

      if (isLoggedIn && onLoginScreen) {
        return '/';
      }


      return null;
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
  );

  CustomTransitionPage customTransitionPage<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Change the opacity of the screen using a Curve based on the the animation's
        // value
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [GoRouterRefreshStream].
  ///
  /// Every time the [stream] receives an event the [GoRouter] will refresh its
  /// current route.
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
