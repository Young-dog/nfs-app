import 'package:app/src/shared/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';

class AppCoreScreen extends StatelessWidget {
  const AppCoreScreen({
    Key? key,
    required this.child,
    required this.location,
  }) : super(key: key);

  final Widget child;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}


