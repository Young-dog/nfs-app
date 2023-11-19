import 'package:app/src/features/app/presentation/blocs/navigation/navigation_cubit.dart';
import 'package:app/src/features/auth/domain/use_cases/login_with_nfs.dart';
import 'package:app/src/shared/data/models/issue_model.dart';
import 'package:app/src/shared/data/models/unit_model.dart';
import 'package:app/src/shared/data/models/vehicle_model.dart';
import 'package:app/src/features/land/presentation/blocs/add_land/add_land_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'services/cache_service.dart';
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

import 'src/features/auth/presentation/blocs/logout/logout_cubit.dart';
import 'src/features/issue/data/data_sources/firestore_issue_data_source.dart';
import 'src/features/issue/data/data_sources/local_issue_data_source.dart';
import 'src/features/issue/data/repositories/issue_repository_impl.dart';
import 'src/features/land/data/data_sources/firestore_land_data_source.dart';
import 'src/features/land/data/data_sources/local_land_data_source.dart';
import 'src/features/land/data/repositories/land_repository_impl.dart';
import 'src/features/land/domain/use_cases/add_land.dart';
import 'src/features/task/data/data_sources/firestore_task_data_source.dart';
import 'src/features/task/data/data_sources/local_task_data_source.dart';
import 'src/features/task/data/repositories/task_repository_impl.dart';
import 'src/shared/data/models/land_model.dart';
import 'src/shared/data/models/land_plant_condition_model.dart';
import 'src/shared/data/models/land_recommendation_model.dart';
import 'src/shared/data/models/land_report_model.dart';
import 'src/shared/data/models/land_soil_condition_model.dart';
import 'src/shared/data/models/task_model.dart';
import 'src/shared/data/models/user_info_model.dart';
import 'src/shared/data/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Кеш
  final cacheService = CacheService(
    firestoreLandDataSource: FirestoreLandDataSourceImpl(),
  );
  await cacheService.init();

  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter()); // 0
  Hive.registerAdapter(LandModelAdapter()); // 1
  Hive.registerAdapter(LandPlantConditionModelAdapter()); // 2
  Hive.registerAdapter(LandSoilConditionModelAdapter()); // 3
  Hive.registerAdapter(LandRecommendationModelAdapter()); // 4
  Hive.registerAdapter(LandReportModelAdapter()); // 5
  Hive.registerAdapter(TaskModelAdapter()); // 6
  Hive.registerAdapter(UserInfoModelAdapter()); // 7
  Hive.registerAdapter(UnitModelAdapter()); //9
  Hive.registerAdapter(VehicleModelAdapter()); // 10
  Hive.registerAdapter(IssueModelAdapter()); //11

  runApp(MyApp(cacheService: cacheService));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required CacheService cacheService,
  });

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
        RepositoryProvider(
          create: (context) => TaskRepositoryImpl(
            LocalTaskDataSourceImpl(),
            FirestoreTaskDataSourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => LandRepositoryImpl(
            LocalLandDataSourceImpl(),
            FirestoreLandDataSourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => IssueRepositoryImpl(
            LocalIssueDataSourceImpl(),
            FirestoreIssueDataSourceImpl(),
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
              authRepository: context.read<AuthRepositoryImpl>(),
            ),
          ),
          BlocProvider(
            create: (context) => LogoutCubit(
              logoutUser: LogoutUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => AddLandCubit(
              addLand: AddLand(
                context.read<LandRepositoryImpl>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => NavigationCubit(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'AngryCorns',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              useMaterial3: true,
              primaryColor: AppColors.primary,
              scaffoldBackgroundColor: AppColors.white,
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
                  color: AppColors.black,
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
