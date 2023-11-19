import 'package:app/src/config/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../shared/widgets/custom_indicator.dart';
import '../../../../shared/widgets/custom_logo.dart';
import '../../../../shared/widgets/custom_widget.dart';
import '../blocs/login_with_nfs/login_with_nfs_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    context.read<LoginWithNfsCubit>().signInWithNfc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginWithNfsCubit, LoginWithNfsState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status == LoginWithNfsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorText.toString()),
            ),
          );
        }
        if (state.status == LoginWithNfsStatus.success) {
          context.goNamed('home');
        }

        print('---> state.status= ${state.status}');

        if (state.status == LoginWithNfsStatus.signUp) {
          context.goNamed('signup');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      AppIcons.bgNfcIcon(null, AppColors.green),
                      Positioned(
                        left: 6,
                        child: AppIcons.nfsIcon(
                          null,
                          Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 43),
                    child: Text(
                      'Включите NFS и приложите  карту к задней панели телефона',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginWithNfs extends StatelessWidget {
  const _LoginWithNfs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginWithNfsCubit, LoginWithNfsState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status == LoginWithNfsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorText.toString()),
            ),
          );
        }
        if (state.status == LoginWithNfsStatus.success) {
          context.goNamed('home');
        }

        print('---> state.status= ${state.status}');

        if (state.status == LoginWithNfsStatus.signUp) {
          context.goNamed('signup');
        }
      },
      builder: (context, state) {
        if (state.status == LoginWithNfsStatus.loading) {
          return const Center(
            child: CustomIndicator(),
          );
        }
        return CustomButton(
          text: 'Войти с помощью NFC',
          onPressed: () => context.read<LoginWithNfsCubit>().signInWithNfc(),
        );
      },
    );
  }
}
