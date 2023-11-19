import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.automaticallyImplyLeading = true,
    this. actions,
  }) : super(key: key);

  final String title;
  final bool automaticallyImplyLeading;
  final List<IconButton>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      // leading: GoRouter.of(context).location != '/' ? IconButton(
      //   icon: const Icon(Icons.arrow_back_ios_new),
      //   onPressed: () {
      //     context.goNamed('student_list');
      //   },
      // ) : null,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline6!
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
