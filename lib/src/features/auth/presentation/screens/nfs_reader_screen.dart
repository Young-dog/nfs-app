import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/login_with_nfs/login_with_nfs_cubit.dart';

class NfcReaderScreen extends StatelessWidget {
  const NfcReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LoginWithNfsCubit, LoginWithNfsState>(
        builder: (context, state) {
          return const Column(
            children: [
              Text('Авторизация по nfc'),
            ],
          );
        },
        listener: (
          BuildContext context,
          LoginWithNfsState state,
        ) {
          if (state.status == LoginWithNfsStatus.success) {
            context.goNamed('home');
          }
        },
      ),
    );
  }
}
