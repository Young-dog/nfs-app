import 'dart:async';

import 'package:app/src/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:app/src/features/land/presentation/screens/land_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/app/presentation/screens/farmer_screen.dart';
import '../features/app/presentation/screens/manager_screen.dart';
import '../features/app/presentation/screens/mechanic_screen.dart';
import '../features/auth/data/data_sources/auth_data_source.dart';
import '../features/auth/presentation/blocs/auth/auth_bloc.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/issue/presentation/screens/farmer_support_screen.dart';
import '../features/issue/presentation/screens/mechanic_support_screen.dart';
import '../features/revenue/presentation/screens/mechanic_revenue_screen.dart';
import '../features/task/presentation/screens/farmer_tasks_screen.dart';
import '../features/task/presentation/screens/mechanic_task_screen.dart';
import '../features/user/presentation/screens/farmer_profile_screen.dart';
import '../features/user/presentation/screens/mechanic_profile_screen.dart';
import '../features/vehicle/presentation/screens/farmer_vehciles_screen.dart';
import '../features/vehicle/presentation/screens/mechanic_vehicle_screen.dart';


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
          var userRole = context.read<AuthBloc>().state.loggedInUser.role.toLowerCase();

          switch(userRole) {
            case 'агроном':
              return FarmerScreen(
                location: state.matchedLocation,
                child: child,
              );
            case 'механизатор':
              return MechanicScreen(
                location: state.matchedLocation,
                child: child,
              );
            case 'диспетчер':
              return ManagerScreen(
                location: state.matchedLocation,
                child: child,
              );
            default:
              return const Scaffold(
                body: Center(
                  child: Text('Вы не выбрали роль!'),
                ),
              );
          }
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
            path: "/m_task",
            name: "m_task",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const MechanicTaskScreen(),
              );
            },
          ),
          GoRoute(
            path: "/f_tasks",
            name: "f_tasks",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const FarmerTasksScreen(),
              );
            },
          ),
          GoRoute(
            path: "/f_vehicles",
            name: "f_vehicles",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const FarmerVehiclesScreen(),
              );
            },
          ),
          GoRoute(
            path: "/m_vehicle",
            name: "m_vehicle",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const MechanicVehicleScreen(),
              );
            },
          ),
          GoRoute(
            path: "/m_revenue",
            name: "m_revenue",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const MechanicRevenueScreen(),
              );
            },
          ),
          GoRoute(
            path: "/f_support",
            name: "f_support",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const FarmerSupportScreen(),
              );
            },
          ),
          GoRoute(
            path: "/m_support",
            name: "m_support",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const MechanicSupportScreen(),
              );
            },
          ),
          GoRoute(
            path: "/m_profile",
            name: "m_profile",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const MechanicProfileScreen(),
              );
            },
          ),
          GoRoute(
            path: "/f_profile",
            name: "f_profile",
            pageBuilder: (BuildContext context, GoRouterState state) {
              return customTransitionPage<void>(
                context: context,
                state: state,
                child: const FarmerProfileScreen(),
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
