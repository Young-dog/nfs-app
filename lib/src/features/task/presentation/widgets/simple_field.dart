import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/app_colors.dart';


class SimpleField extends StatefulWidget {
  const SimpleField({
    this.labelText = '',
    this.numLines = 1,
    this.autoFocus = false,
    this.obscureText = false,
    this.initialValue,
    this.labelStyle,
    this.maxLength,
    this.keyboardType,
    this.onChanged,
    this.onSubmit,
    this.onTap,
    this.errorText,
    this.hintText,
    this.controller,
    this.autofillHints,
    this.suffixIcon,
    this.readOnly = false,
    this.focusNode,
    this.inputFormatters,
    this.mask,
    this.enabled,
    this.enabledBorder,
    this.border,
    super.key,
  });

  final InputBorder? enabledBorder;
  final InputBorder? border;
  final String? initialValue;
  final String labelText;
  final TextStyle? labelStyle;
  final int numLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmit;
  final void Function()? onTap;
  final String? errorText;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? mask;
  final TextEditingController? controller;
  final List<String>? autofillHints;
  final bool obscureText;
  final bool autoFocus;
  final bool readOnly;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool? enabled;

  @override
  State<SimpleField> createState() => _SimpleFieldState();
}

class _SimpleFieldState extends State<SimpleField> {
  String? _initialValue;

  @override
  void initState() {
    final initialValue = widget.initialValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            TextFormField(
              enabled: widget.enabled,
              focusNode: widget.focusNode,
              readOnly: widget.readOnly,
              controller: widget.controller,
              autofillHints: widget.autofillHints,
              inputFormatters: [
                // LengthLimitingTextInputFormatter(maxLength),

                if (widget.inputFormatters != null)
                  ...widget.inputFormatters!,
              ],
              keyboardType: widget.keyboardType,
              onFieldSubmitted: widget.onSubmit,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              initialValue: _initialValue,
              autofocus: widget.autoFocus,
              minLines: widget.numLines,
              maxLines: widget.numLines,
              obscureText: widget.obscureText,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                labelText: widget.labelText,
                hintText: widget.hintText,
                iconColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.focused)) {
                      return AppColors.grey;
                    }

                    return AppColors.grey;
                  },
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.grey,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.grey,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                filled: true,
                fillColor: Colors.transparent,
                labelStyle: theme.textTheme.bodyLarge!.copyWith(
                  color: AppColors.grey,
                ),
                floatingLabelStyle: theme.textTheme.bodyLarge!.copyWith(
                  color: AppColors.grey,
                ),
                contentPadding: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 20,
                  right: 32,
                ),
              ),
            ),
            if (widget.suffixIcon != null)
              Positioned(
                top: 0,
                bottom: 0,
                right: 16,
                child: Center(
                  child: widget.suffixIcon,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

