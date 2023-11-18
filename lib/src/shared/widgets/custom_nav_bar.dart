
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/app_colors.dart';
import '../../config/app_icons.dart';
import '../../features/app/presentation/blocs/navigation/navigation_cubit.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  late List<AppNavBarItem> aTabs;
  late List<AppNavBarItem> mTabs;

  @override
  void initState() {
    aTabs = [
      AppNavBarItem(
        initialLocation: '/',
        label: 'Главная',
        icon: AppIcons.home(null, AppColors.blue),
        activeIcon: AppIcons.home(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/tasks',
        label: 'Задачи',
        icon: AppIcons.inbox(null, AppColors.blue),
        activeIcon: AppIcons.inbox(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/issues',
        label: 'Проблемы',
        icon: AppIcons.inbox(null, AppColors.blue),
        activeIcon: AppIcons.inbox(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/profile',
        label: 'Профиль',
        icon: AppIcons.person(null, AppColors.blue),
        activeIcon: AppIcons.person(null, AppColors.lightBlue),
      ),
    ];
    mTabs = [
      AppNavBarItem(
        initialLocation: '/m_tasks',
        label: 'Задачи',
        icon: AppIcons.home(null, AppColors.blue),
        activeIcon: AppIcons.home(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/m_vehicle',
        label: 'Техника',
        icon: AppIcons.inbox(null, AppColors.blue),
        activeIcon: AppIcons.inbox(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/m_revenue',
        label: 'Доход',
        icon: AppIcons.inbox(null, AppColors.blue),
        activeIcon: AppIcons.inbox(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/m_support',
        label: 'Поддержка',
        icon: AppIcons.inbox(null, AppColors.blue),
        activeIcon: AppIcons.inbox(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/profile',
        label: 'Профиль',
        icon: AppIcons.person(null, AppColors.blue),
        activeIcon: AppIcons.person(null, AppColors.lightBlue),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: state.index,
          showUnselectedLabels: false,
          backgroundColor: AppColors.white,
          selectedItemColor: AppColors.lightBlue,
          unselectedItemColor: AppColors.blue,
          items: aTabs,
          onTap: (index) {
            if (index == 0) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.home);
            } else if (index == 1) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.tasks);
            } else if (index == 2) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.issues);
            }  else if (index == 3) {
              BlocProvider.of<NavigationCubit>(context)
                  .getNavBarItem(NavbarItem.profile);
            }
          },
        );
      },
    );
  }
}


class AppNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const AppNavBarItem(
      {required this.initialLocation,
        required Widget icon,
        String? label,
        Widget? activeIcon})
      : super(
    icon: icon,
    label: label,
    activeIcon: activeIcon ?? icon,
  );
}
