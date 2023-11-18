import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/app_colors.dart';


class FilledInput extends StatelessWidget {
  const FilledInput({
    this.labelText,
    this.numLines,
    this.style,
    this.autoFocus = false,
    this.obscureText = false,
    this.initialValue,
    this.labelStyle,
    this.maxLength,
    this.keyboardType,
    this.onChanged,
    this.onSubmit,
    this.hintText,
    this.controller,
    this.autofillHints,
    this.suffixIcon,
    this.suffix,
    this.textAlign = TextAlign.start,
    super.key,
  });

  final String? initialValue;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final int? numLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmit;
  final String? hintText;
  final TextEditingController? controller;
  final List<String>? autofillHints;
  final bool obscureText;
  final bool autoFocus;
  final Widget? suffixIcon;
  final Widget? suffix;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    // return const Placeholder();

    final theme = Theme.of(context);

    return TextFormField(
      textAlign: textAlign,
      textInputAction: TextInputAction.done,
      style: style,
      controller: controller,
      autofillHints: autofillHints,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      keyboardType: keyboardType,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      initialValue: initialValue,
      autofocus: autoFocus,
      minLines: numLines,
      maxLines: numLines,
      obscureText: obscureText,
      decoration: InputDecoration(
        counterText: '',
        labelText: labelText,
        hintText: hintText,
        suffixIcon: suffixIcon,
        suffix: suffix,
        iconColor: MaterialStateColor.resolveWith(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.focused)) {
              return AppColors.grey;
            }

            return AppColors.greyishBlue;
          },
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        labelStyle: theme.textTheme.bodyLarge,
        floatingLabelStyle: theme.textTheme.bodyLarge,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
      ),
    );
  }
}