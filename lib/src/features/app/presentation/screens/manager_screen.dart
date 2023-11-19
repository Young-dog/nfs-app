import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_icons.dart';


class ManagerScreen extends StatefulWidget {
  const ManagerScreen({
    Key? key,
    required this.child,
    required this.location,
  }) : super(key: key);

  final Widget child;
  final String location;

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  int _currentIndex = 0;
  late List<AppNavBarItem> tabs;

  @override
  void initState() {
    tabs = [
      AppNavBarItem(
        initialLocation: '/m_tasks',
        label: 'Задачи',
        icon: AppIcons.inbox(null, AppColors.blue),
        activeIcon: AppIcons.inbox(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/m_tasks',
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
      case '/':
        return 0;
      case '/tasks':
        return 1;
      case '/issues':
        return 2;
      case '/profile':
        return 3;
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