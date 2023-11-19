import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/search.dart';

class FarmerTasksScreen extends StatelessWidget {
  const FarmerTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            ListView(
              children: [
                SizedBox(height: 20,),
                Search(),
              ],
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
        ),
      ),
    );
  }
}
