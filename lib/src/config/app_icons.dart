import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static Widget close([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/close.svg', color, sized);
  static Widget down([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/down.svg', color, sized);
  static Widget field([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/field.svg', color, sized);
  static Widget filter([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/filter.svg', color, sized);
  static Widget list([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/list.svg', color, sized);
  static Widget notification([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/notification.svg', color, sized);
  static Widget plus([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/plus.svg', color, sized);
  static Widget profile([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/profile.svg', color, sized);
  static Widget support([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/support.svg', color, sized);
  static Widget tractor([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/tractor.svg', color, sized);
  static Widget wallet([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/wallet.svg', color, sized);
  static Widget profilePic([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/profile_pic.svg', color, sized);
  static Widget nfsIcon([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/nfc_icon.svg', color, sized);
  static Widget bgNfcIcon([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/bg_nfs_icon.svg', color, sized);
  static Widget exit([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/exit.svg', color, sized);
  static Widget edit([double? sized, Color? color]) =>
      _AppIconWidget('assets/icons/edit.svg', color, sized);
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
