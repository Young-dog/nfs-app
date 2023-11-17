import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/app/app_core.dart';
import '../features/app/home_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';


class AppRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>();

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'login',
        pageBuilder: (BuildContext context, GoRouterState state) {
          return customTransitionPage<void>(
            context: context,
            state: state,
            child: const LoginScreen(),
          );
        },
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppCore(
            location: state.matchedLocation,
            child: child,
          );
        },
        routes: [
          GoRoute(
              path: "/home",
              name: "home",
              pageBuilder: (BuildContext context, GoRouterState state) {
                return customTransitionPage<void>(
                  context: context,
                  state: state,
                  child: const HomeScreen(),
                );
              },
          ),
        ],
      ),
    ],
    // redirect: (
    //   BuildContext context,
    //   GoRouterState state,
    // ) async {
    //
    //   // if the user is not logged in, they need to login
    //   final loggedIn = authBloc.state.status == AuthStatus.authenticated;
    //   final loggingIn =  state.subloc == '/login';
    //
    //   // bundle the location the user is coming from into a query parameter
    //   final fromp = state.subloc == '/' ? '' : '?from=${state.subloc}';
    //   if (!loggedIn) return loggingIn ? null : '/login$fromp';
    //
    //   // if the user is logged in, send them where they were going before (or
    //   // home if they weren't going anywhere)
    //   if (loggingIn) return state.queryParams['from'] ?? '/';
    //
    //   // no need to redirect at all
    //   return null;
    //
    // },
    // refreshListenable: GoRouterRefreshStream(authBloc.stream),
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
