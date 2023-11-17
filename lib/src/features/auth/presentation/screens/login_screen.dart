import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/custom_indicator.dart';
import '../../../../shared/widgets/custom_logo.dart';
import '../blocs/login_with_nfs/login_with_nfs_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomLogo(
                height: 45,
                width: 45,
                fontSize: 32,
              ),
              const SizedBox(height: 20),
              Text(
                'Мобильное приложение механизатора',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const _LoginWithNfs(),
            ],
          ),
        ),
      ),
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
      },
      builder: (context, state) {
        if (state.status == LoginWithNfsStatus.loading) {
          return const Center(
            child: CustomIndicator(),
          );
        }
        return _Button(
          icon: 'google',
          text: 'Войти с помощью NFC',
          onPressed: () =>
              context.read<LoginWithNfsCubit>().signInWithNfs(),
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  final String icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Colors.grey,
          ),
        ),
        fixedSize: const Size(250, 50),
      ),
      onPressed: onPressed,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: SvgPicture.asset(
                'assets/icons/$icon.svg',
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
