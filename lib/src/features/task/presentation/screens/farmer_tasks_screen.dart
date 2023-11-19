import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_colors.dart';
import '../../../../shared/domain/entities/task.dart';
import '../../../../shared/widgets/custom_failure.dart';
import '../../../../shared/widgets/custom_indicator.dart';
import '../blocs/task/task_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/search.dart';

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
              return Stack(
                children: [
                  ListView.separated(
                    itemBuilder: (context, index) {
                      var task = state.tasks[index];
                      return _TaskCard(task: task);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 8);
                    },
                    itemCount: state.tasks.length,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 8,
                    child: IconButton(
                      iconSize: 50,
                      onPressed: () {
                        context.goNamed('f_new_task');
                      },
                      icon: Icon(
                        Icons.add_circle,
                      ),
                    ),
                  ),
                ],
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
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 7,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 14,
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.black,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.grey,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (task.landId.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: Text(
                    task.landId,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50)),
                ),
              if (task.assignedTo != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: Text(
                    task.assignedTo!.name,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50)),
                )
            ],
          ),
          Text(
            task.title,
            style: theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          ),
          Text(
            task.title,
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              color: AppColors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
