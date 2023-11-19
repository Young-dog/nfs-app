import 'package:flutter/material.dart';

import '../../../../shared/widgets/custom_app_bar.dart';

class FarmerNewLandScreen extends StatelessWidget {
  const FarmerNewLandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Новое поле',
      ),
      body: Center(
        child: Text('Пока ничего'),
      ),
    );
  }
}
