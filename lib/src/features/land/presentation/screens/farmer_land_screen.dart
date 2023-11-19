import 'package:app/src/config/app_icons.dart';
import 'package:app/src/features/land/presentation/blocs/add_land/add_land_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_colors.dart';
import '../../../../shared/widgets/custom_indicator.dart';
import '../../../../shared/widgets/custom_widget.dart';

class FarmerLandScreen extends StatelessWidget {
  const FarmerLandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(45),
          ),
        ),
        backgroundColor: AppColors.secondary,
        onPressed: () => context.goNamed('f_new_land'),
        child: AppIcons.plus(null, AppColors.white),
      ),
      body: const Center(
        child: _AddButton(),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddLandCubit, AddLandState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      listener: (context, state) {
        if (state.status == AddLandStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorText.toString()),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == AddLandStatus.loading) {
          return const Center(
            child: CustomIndicator(),
          );
        }
        return CustomButton(
          text: 'Добавить',
          onPressed: () => context.read<AddLandCubit>().submit(),
        );
      },
    );
  }
}
