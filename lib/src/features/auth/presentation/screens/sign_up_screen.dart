import 'package:app/src/features/auth/presentation/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:app/src/shared/data/models/role_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/dropdown_field.dart';
import '../widgets/filled_input.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocConsumer<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return ListView(
                children: [
                  const SizedBox(
                    height: 24,
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
                  ElevatedButton(
                    onPressed: () {
                      context.read<SignUpBloc>().add(const SubmitEvent());
                    },
                    child: Text('Зарегистрироваться'),
                  ),
                ],
              );
            }, listener: (BuildContext context, SignUpState state) { if(state.status.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Заполните все поля')));
          }
    },
          ),
        ),
      ),
    );
  }
}
