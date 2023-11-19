import 'package:app/src/config/app_colors.dart';
import 'package:app/src/features/auth/presentation/widgets/dropdown_field.dart';
import 'package:app/src/features/auth/presentation/widgets/filled_input.dart';
import 'package:app/src/features/task/presentation/widgets/date_time_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../land/presentation/screens/check_box_field.dart';

class FarmerNewTaskScreen extends StatelessWidget {
  const FarmerNewTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
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
          child: ListView(
            children: [
              SizedBox(
                height: 24,
              ),
              FilledInput(
                labelText: 'Название здачи',
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: DateTimeField(
                    labelText: 'Дата',
                    onChanged: (DateTime value) {},
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: DropdownField(
                    labelText: 'Поле',
                    values: [],
                    toText: (value) => value,
                  ))
                ],
              ),
              DropdownField(
                labelText: 'Исполнитель',
                values: [],
                toText: (value) => value,
              ),
              DropdownField(
                labelText: 'Техника',
                values: [],
                toText: (value) => value,
              ),
              DropdownField(
                labelText: 'Агрегат',
                values: [],
                toText: (value) => value,
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledInput(
                      labelText: 'Глубина, см',
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: FilledInput(
                      labelText: 'Рабочая скорость, км/ч',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              FilledInput(
                labelText: 'Расход  раствора, л/га',
              ),
              SizedBox(
                height: 16,
              ),
              FilledInput(
                labelText: 'Описание задачи',
                suffixIcon: Icon(Icons.keyboard_voice_outlined),
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxField(
                value: false,
                onChanged: ({value}) {},
                labelText: 'Учет времени',
              ),
              SizedBox(
                height: 16,
              ),
              CheckboxField(
                value: false,
                onChanged: ({value}) {},
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
                  onPressed: () {},
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
          ),
        ),
      ),
    );
  }
}
