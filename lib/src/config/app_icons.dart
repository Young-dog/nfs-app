import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static Widget person([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/person.svg', color, sized);
  static Widget search([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/search.svg', color, sized);
  static Widget phone([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/phone.svg', color, sized);
  static Widget more([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/more.svg', color, sized);
  static Widget list([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/list.svg', color, sized);
  static Widget language([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/language.svg', color, sized);
  static Widget inbox([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/inbox.svg', color, sized);
  static Widget howTo([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/how_to.svg', color, sized);
  static Widget home([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/home.svg', color, sized);
  static Widget exit([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/exit.svg', color, sized);
  static Widget edit([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/edit.svg', color, sized);
  static Widget directions([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/directions.svg', color, sized);
  static Widget back([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/back.svg', color, sized);
  static Widget add([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/add.svg', color, sized);
  static Widget add2([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/add_2.svg', color, sized);
  static Widget profilePic([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/profile_pic.svg', color, sized);
}

class _AppIconWidget extends StatelessWidget {
  final String assetUrl;
  final Color? color;
  final double? size;
  const _AppIconWidget(this.assetUrl, this.color, this.size);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetUrl,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? Colors.black,
        BlendMode.srcATop,
      ),
      fit: BoxFit.scaleDown,
    );
  }
}
