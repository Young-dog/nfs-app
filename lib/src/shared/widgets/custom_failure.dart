import 'package:flutter/material.dart';

class CustomFailure extends StatelessWidget {
  const CustomFailure({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
