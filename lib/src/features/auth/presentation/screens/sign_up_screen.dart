import 'package:app/src/features/auth/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:app/src/shared/data/models/role_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../blocs/login_with_nfs/login_with_nfs_cubit.dart';
import '../widgets/dropdown_field.dart';
import '../widgets/filled_input.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<LoginWithNfsCubit, LoginWithNfsState>(
      listener: (context, state) {
        if (state.status == LoginWithNfsStatus.success) {
          context.goNamed('home');
        }
      },
      builder: (context, state) {
        if (state.status == LoginWithNfsStatus.loading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return BlocProvider(
          create: (context) => SignUpBloc(),
          child: SafeArea(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                backgroundColor: AppColors.white,
                appBar: AppBar(
                  elevation: 0,
                  title: Text(
                    'Вы тут впервые',
                    style: theme.textTheme.titleLarge!.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                  ),
                  child: BlocConsumer<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      return ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'Пожалуйста представьтесь',
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FilledInput(
                            initialValue: state.firstName.value,
                            labelText: 'Имя',
                            onChanged: (value) {
                              context.read<SignUpBloc>().add(
                                    ChangeFirstNameEvent(
                                      value: value,
                                    ),
                                  );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FilledInput(
                            initialValue: state.lastName.value,
                            labelText: 'Фамилия',
                            onChanged: (value) {
                              context.read<SignUpBloc>().add(
                                    ChangeLastNameEvent(
                                      value: value,
                                    ),
                                  );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          FilledInput(
                            initialValue: state.middleName,
                            labelText: 'Отчество',
                            onChanged: (value) {
                              context.read<SignUpBloc>().add(
                                    ChangeMiddleNameEvent(
                                      value: value,
                                    ),
                                  );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownField<RoleUser>(
                            labelText: 'Роль',
                            values: RoleUser.values,
                            toText: (value) => value.toText(),
                            onChanged: (value) {
                              context.read<SignUpBloc>().add(
                                    ChangeRoleEvent(
                                      value: value,
                                    ),
                                  );
                            },
                          ),
                          if (state.role.value == RoleUser.machineOperator)
                            Column(
                              children: [
                                Text(
                                  'Добавьте транспорт',
                                  style: theme.textTheme.titleMedium!.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(
                                  height: 16,
                                ),
                                DropdownField(
                                  labelText: 'Техника',
                                  values: [],
                                  toText: (value) => value.toText(),
                                  onChanged: (value) {},
                                ),
                                DropdownField(
                                  labelText: 'Агрегат',
                                  values: [],
                                  toText: (value) => value.toText(),
                                  onChanged: (value) {},
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                              ],
                            ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 56,
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(AppColors.primary),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                context
                                    .read<SignUpBloc>()
                                    .add(const SubmitEvent());
                              },
                              child: Text(
                                'Сохранить',
                                style: theme.textTheme.titleLarge!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      );
                    },
                    listener: (BuildContext context, SignUpState state) {
                      if (state.status.isFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Заполните все поля')));
                      }
                      if (state.status.isSubmitted) {
                        context.read<LoginWithNfsCubit>().signUp(
                              lastName: state.lastName.value,
                              firstName: state.firstName.value,
                              middleName: state.middleName,
                              role: state.role.value!.toText(),
                            );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
