import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_icons.dart';


class MechanicScreen extends StatefulWidget {
  const MechanicScreen({
    Key? key,
    required this.child,
    required this.location,
  }) : super(key: key);

  final Widget child;
  final String location;

  @override
  State<MechanicScreen> createState() => _MechanicScreenState();
}

class _MechanicScreenState extends State<MechanicScreen> {
  int _currentIndex = 0;
  late List<AppNavBarItem> tabs;

  @override
  void initState() {
    tabs = [
      AppNavBarItem(
        initialLocation: '/m_task',
        label: 'Задачи',
        icon: AppIcons.inbox(null, AppColors.blue),
        activeIcon: AppIcons.inbox(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/m_vehicle',
        label: 'Техника',
        icon: AppIcons.inbox(null, AppColors.blue),
        activeIcon: AppIcons.home(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/m_revenue',
        label: 'Доход',
        icon: AppIcons.inbox(null, AppColors.blue),
        activeIcon: AppIcons.home(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/m_support',
        label: 'Поддержка',
        icon: AppIcons.inbox(null, AppColors.blue),
        activeIcon: AppIcons.inbox(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/m_profile',
        label: 'Профиль',
        icon: AppIcons.person(null, AppColors.blue),
        activeIcon: AppIcons.person(null, AppColors.lightBlue),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) => _goOtherTab(context, index),
        currentIndex: switchCurrentIndex(widget.location),
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.lightBlue,
        unselectedItemColor: AppColors.blue,
        items: tabs,
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _currentIndex = index;
    });

    router.go(location);
  }

  switchCurrentIndex(String location) {
    switch (location) {
      case '/m_task':
        return 0;
      case '/m_vehicle':
        return 1;
      case '/m_revenue':
        return 2;
      case '/m_support':
        return 3;
      case '/m_profile':
        return 4;
      default:
        return 0;
    }
  }
}

class AppNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const AppNavBarItem({required this.initialLocation,
    required Widget icon,
    String? label,
    Widget? activeIcon})
      : super(
    icon: icon,
    label: label,
    activeIcon: activeIcon ?? icon,
  );
}