import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({
    super.key,
    required this.height,
    required this.width,
    required this.fontSize,
    this.onTap,
  });

  final double height;
  final double width;
  final double fontSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: height,
            width: width,
            child: const FlutterLogo(),
          ),
          // SvgPicture.asset(
          //   height: height,
          //   width: width,
          //   'assets/icons/logo_ic.svg',
          // ),
          const SizedBox(width: 8),
          Text(
            'Angry Corns',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
