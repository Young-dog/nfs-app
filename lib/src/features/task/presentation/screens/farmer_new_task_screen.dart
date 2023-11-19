import 'package:app/src/config/app_colors.dart';
import 'package:app/src/features/auth/presentation/widgets/dropdown_field.dart';
import 'package:app/src/features/auth/presentation/widgets/filled_input.dart';
import 'package:app/src/features/task/presentation/blocs/add_task/add_task_cubit.dart';
import 'package:app/src/features/task/presentation/blocs/add_task_bloc.dart';
import 'package:app/src/features/task/presentation/widgets/date_time_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../land/presentation/screens/check_box_field.dart';

class FarmerNewTaskScreen extends StatelessWidget {
  const FarmerNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => AddTaskBloc(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Новая задача',
              style: theme.textTheme.titleLarge!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            leading: Container(),
            actions: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.close,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: BlocConsumer<AddTaskBloc, AddTaskState>(
              builder: (context, state) {
                return ListView(
                  children: [
                    SizedBox(
                      height: 24,
                    ),
                    FilledInput(
                      labelText: 'Название здачи',
                      initialValue: state.title.value,
                      onChanged: (value) {
                        context.read<AddTaskBloc>().add(
                              ChangeTitleTaskEvent(
                                title: value,
                              ),
                            );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: DateTimeField(
                          initialValue: state.date.value,
                          labelText: 'Дата',
                          onChanged: (DateTime value) {
                            context.read<AddTaskBloc>().add(
                                  ChangeDateTaskEvent(
                                    date: value,
                                  ),
                                );
                          },
                        )),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: DropdownField(
                          onChanged: (value) {
                            context.read<AddTaskBloc>().add(
                                  ChangeLandTaskEvent(
                                    land: value,
                                  ),
                                );
                          },
                          labelText: 'Поле',
                          values: [],
                          toText: (value) => value,
                        ))
                      ],
                    ),
                    DropdownField(
                      onChanged: (value) {
                        context.read<AddTaskBloc>().add(
                              ChangeAssignedTaskEvent(
                                assigned: value,
                              ),
                            );
                      },
                      labelText: 'Исполнитель',
                      values: [],
                      toText: (value) => value,
                    ),
                    DropdownField(
                      onChanged: (value) {
                        context.read<AddTaskBloc>().add(
                              ChangeVehicleTaskEvent(
                                vehicle: value,
                              ),
                            );
                      },
                      labelText: 'Техника',
                      values: [],
                      toText: (value) => value,
                    ),
                    DropdownField(
                      onChanged: (value) {
                        context.read<AddTaskBloc>().add(
                              ChangeUnitTaskEvent(
                                unit: value,
                              ),
                            );
                      },
                      labelText: 'Агрегат',
                      values: [],
                      toText: (value) => value,
                    ),
                    if (state.vehicle != null && state.unit != null)
                      Row(
                        children: [
                          Expanded(
                            child: FilledInput(
                              readOnly: true,
                              initialValue: state.unit!.depth,
                              labelText: 'Глубина, см',
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: FilledInput(
                              readOnly: true,
                              initialValue: state.vehicle!.workingSpeed,
                              labelText: 'Рабочая скорость, км/ч',
                            ),
                          ),
                        ],
                      ),
                    if (state.vehicle != null && state.unit != null)
                      SizedBox(
                        height: 16,
                      ),
                    if (state.vehicle != null && state.unit != null)
                      FilledInput(
                        readOnly: true,
                        initialValue: state.unit!.consumptionSolution,
                        labelText: 'Расход  раствора, л/га',
                      ),
                    if (state.vehicle != null && state.unit != null)
                      SizedBox(
                        height: 16,
                      ),
                    FilledInput(
                      initialValue: state.description.value,
                      labelText: 'Описание задачи',
                      suffixIcon: Icon(Icons.keyboard_voice_outlined),
                      onChanged: (value) {
                        context.read<AddTaskBloc>().add(
                              ChangeDescriptionTaskEvent(
                                description: value,
                              ),
                            );
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CheckboxField(
                      value: state.time,
                      onChanged: ({value}) {
                        context.read<AddTaskBloc>().add(
                              ChangeTimeTaskEvent(
                                value: value ?? false,
                              ),
                            );
                      },
                      labelText: 'Учет времени',
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CheckboxField(
                      value: state.priority,
                      onChanged: ({value}) {
                        context.read<AddTaskBloc>().add(
                              ChangePriorityTaskEvent(
                                value: value ?? false,
                              ),
                            );
                      },
                      labelText: 'Приоритетная задача',
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
                          context.read<AddTaskBloc>().add(
                                SubmitTaskEvent(),
                              );
                        },
                        child: Text(
                          'Добавить',
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
              listener: (BuildContext context, AddTaskState state) {
                if (state.statusTask.isFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Не все обязательные поля заполнены')));
                }
                if (state.statusTask.isSubmitted) {
                  context.read<AddTaskCubit>().
              },
            ),
          ),
        ),
      ),
    );
  }
}
