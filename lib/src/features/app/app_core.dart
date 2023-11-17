
import 'package:flutter/material.dart';

class AppCore extends StatelessWidget {
  AppCore({
    super.key,
    required this.child,
    required this.location,
  });

  final Widget child;
  final String location;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(child: child),
    );
  }
}
