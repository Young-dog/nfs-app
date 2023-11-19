import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/domain/entities/task.dart';
import '../../../../shared/widgets/custom_failure.dart';
import '../../../../shared/widgets/custom_indicator.dart';
import '../blocs/task/task_bloc.dart';

class FarmerTasksScreen extends StatelessWidget {
  const FarmerTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TaskBloc, TaskState>(
        bloc: context.read<TaskBloc>()..add(LoadTask()),
        listener: (context, state) {
          if (state is TaskFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is TaskFailure) {
            return CustomFailure(message: state.message);
          } else if (state is TaskLoading) {
            return const CustomIndicator();
          } else if (state is TaskLoaded) {
            if (state.tasks.isEmpty) {
              return const CustomFailure(message: 'Вы еще не добавили задачи');
            } else {
              return ListView.separated(
                itemBuilder: (context, index) {
                  var task = state.tasks[index];
                  return _TaskCard(task: task);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
                itemCount: state.tasks.length,
              );
            }
          }
          return const Center(
            child: CustomFailure(message: 'Что-то пошло не так'),
          );
        },
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
    );
  }
}

