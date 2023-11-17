import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/config/app_router.dart';
import 'src/features/auth/data/data_sources/auth_data_source.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/domain/use_cases/get_auth_status.dart';
import 'src/features/auth/domain/use_cases/get_auth_user.dart';
import 'src/features/auth/domain/use_cases/logout_user.dart';
import 'src/features/auth/presentation/blocs/auth/auth_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter(CategoryModelAdapter()); // 0
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl(
            AuthDataSourceImpl(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              getAuthStatus: GetAuthStatus(
                context.read<AuthRepositoryImpl>(),
              ),
              getAuthUser: GetAuthUser(
                context.read<AuthRepositoryImpl>(),
              ),
              logoutUser: LogoutUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
          // BlocProvider(
          //   create: (context) => LogoutCubit(
          //     logoutUser: LogoutUser(
          //       context.read<AuthRepositoryImpl>(),
          //     ),
          //   ),
          // ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'AngryCorns',
            debugShowCheckedModeBanner: false,
            // theme: context.theme.appThemeData,
            routerConfig: AppRouter().router,
          );
        }),
      ),
    );
  }
}

