import 'package:flutter/material.dart';

class LandListScreen extends StatelessWidget {
  const LandListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
