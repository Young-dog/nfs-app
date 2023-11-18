import 'package:app/src/features/auth/domain/use_cases/login_with_nfs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'src/config/app_colors.dart';
import 'src/config/app_router.dart';
import 'src/config/app_text_styles.dart';
import 'src/features/auth/data/data_sources/auth_data_source.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/domain/use_cases/get_auth_status.dart';
import 'src/features/auth/domain/use_cases/get_auth_user.dart';
import 'src/features/auth/domain/use_cases/logout_user.dart';
import 'src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'src/features/auth/presentation/blocs/login_with_nfs/login_with_nfs_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/shared/data/models/user_model.dart';

void main() async {
 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter()); // 0
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
          BlocProvider(
            create: (context) => LoginWithNfsCubit(
              loginWithNfs: LoginWithNfs(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'AngryCorns',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              useMaterial3: true,
              primaryColor: AppColors.lightBlue,
              scaffoldBackgroundColor: AppColors.background,
              canvasColor: AppColors.white,
              shadowColor: AppColors.grey,
              iconTheme: IconThemeData(
                color: AppColors.grey,
              ),
              brightness: Brightness.light,
              appBarTheme: AppBarTheme(
                elevation: 1,
                centerTitle: false,
                backgroundColor: AppColors.white,
                titleTextStyle: AppTextStyles.headline1Style.copyWith(
                  color: AppColors.blue,
                ),
              ),
            ),
            routerConfig: AppRouter(context.read<AuthBloc>()).router,
          );
        }),
      ),
    );
  }
}
