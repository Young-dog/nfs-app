import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_icons.dart';
import '../../../../config/app_text_styles.dart';
import '../../../../shared/widgets/custom_indicator.dart';
import '../../../auth/presentation/blocs/logout/logout_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 24.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const _ProfileInfoWidget(),
              const SectionTitleWidget('Документы'),
              SizedBox(
                height: 120,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    _DocCardWidget(
                      icon: AppIcons.howTo(24, AppColors.blue),
                      title: 'Паспорт РФ',
                      value: '87 35 ---22',
                    ),
                    _DocCardWidget(
                      icon: AppIcons.list(24, AppColors.blue),
                      title: 'ИНН',
                      value: null,
                    ),
                    _DocCardWidget(
                      icon: AppIcons.list(24, AppColors.blue),
                      title: 'СНИЛС',
                      value: null,
                    ),
                    _DocCardWidget(
                      icon: AppIcons.directions(24, AppColors.blue),
                      title: 'Водительское удостоверение',
                      value: null,
                    ),
                    _DocCardWidget(
                      icon: AppIcons.language(24, AppColors.blue),
                      title: 'Загранпаспорт',
                      value: null,
                    ),
                  ],
                ),
              ),
              const SectionTitleWidget('Контакты'),
              const _ContactTileWidget(
                title: 'Телефоны',
                value: '+7 (978) 657-23-77',
              ),
              const _ContactTileWidget(
                title: 'Электронная почта',
                value: null,
              ),
              const _ContactTileWidget(
                title: 'Адреса',
                value: null,
              ),
              const SectionTitleWidget('Настройки'),
              const _TileWidget(title: 'Уведомления'),
              const _TileWidget(title: 'Безопасность'),
              const SectionTitleWidget('Помощь'),
              const _TileWidget(title: 'Связь с банком'),
              const _TileWidget(title: 'О приложении'),
              const SizedBox(height: 42),
              _LogoutButtonWidget(
                onTap: () => context.read<LogoutCubit>().submit(),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitleWidget extends StatelessWidget {
  final String title;

  const SectionTitleWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: AppTextStyles.headline1Style.copyWith(
          color: AppColors.greyishBlue,
        ),
      ),
    );
  }
}


class _TileWidget extends StatelessWidget {
  final String title;

  const _TileWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.textSmallStyle.copyWith(
            color: AppColors.blue,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Divider(
            color: AppColors.greyishBlue,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class _ContactTileWidget extends StatelessWidget {
  final String title;
  final String? value;

  const _ContactTileWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.textSmallStyle.copyWith(
                  color: AppColors.blue,
                ),
              ),
              AppIcons.add(16, AppColors.blue)
            ],
          ),
        ),
        if (value != null)
          Text(
            value!,
            style: AppTextStyles.footnoteStyle.copyWith(color: AppColors.grey),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Divider(
            color: AppColors.greyishBlue,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class _DocCardWidget extends StatelessWidget {
  final Widget icon;
  final String title;
  final String? value;

  const _DocCardWidget({
    required this.icon,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 12),
      width: 120,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: icon,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.textSmallStyle.copyWith(
                color: AppColors.blue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              value ?? '',
              style: AppTextStyles.footnoteStyle.copyWith(
                color: AppColors.greyishBlue,
              ),
            ),
          ),
          const Spacer(),
          if (value == null)
            Align(
              alignment: Alignment.bottomRight,
              child: AppIcons.add2(24, AppColors.blue),
            ),
        ],
      ),
    );
  }
}

class _LogoutButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const _LogoutButtonWidget({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status == LogoutStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorText.toString()),
            ),
          );
        }
        // if (state.status == LogoutStatus.success) {
        //   context.goNamed('home');
        // }
      },
      builder: (context, state) {
        if (state.status == LogoutStatus.loading) {
          return const Center(
            child: CustomIndicator(),
          );
        }
        return InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIcons.exit(24, AppColors.lightBlue),
              const SizedBox(width: 8),
              Text(
                'Выйти из приложения',
                style: AppTextStyles.textStyle.copyWith(
                  color: AppColors.lightBlue,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileInfoWidget extends StatelessWidget {
  const _ProfileInfoWidget();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: AppColors.white,
      type: MaterialType.card,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 120,
                child: Image.asset(
                  'assets/images/profile_pic.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: SizedBox(
                        child: AppIcons.edit(24, AppColors.blue),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Text(
                      'Александр\nСергеевич Яровцев',
                      style: AppTextStyles.headline2Style.copyWith(
                        color: AppColors.darkBlue,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}