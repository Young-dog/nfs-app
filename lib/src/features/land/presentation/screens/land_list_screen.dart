import 'package:app/src/features/land/presentation/blocs/add_land/add_land_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandListScreen extends StatelessWidget {
  const LandListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<AddLandCubit>().addLand();
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );

    return const Placeholder();

  }
}
