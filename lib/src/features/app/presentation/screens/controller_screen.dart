import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_icons.dart';


class ControllerScreen extends StatefulWidget {
  const ControllerScreen({
    Key? key,
    required this.child,
    required this.location,
  }) : super(key: key);

  final Widget child;
  final String location;

  @override
  State<ControllerScreen> createState() => _ControllerScreenState();
}

class _ControllerScreenState extends State<ControllerScreen> {
  int _currentIndex = 0;
  late List<AppNavBarItem> tabs;

  @override
  void initState() {
    tabs = [
      AppNavBarItem(
        initialLocation: '/c_support',
        label: 'Поддержка',
        icon: AppIcons.support(null, AppColors.blue),
        activeIcon: AppIcons.support(null, AppColors.lightBlue),
      ),
      AppNavBarItem(
        initialLocation: '/c_profile',
        label: 'Профиль',
        icon: AppIcons.profile(null, AppColors.blue),
        activeIcon: AppIcons.profile(null, AppColors.lightBlue),
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
      case '/c_support':
        return 0;
      case '/c_profile':
        return 1;
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