import 'package:flutter/material.dart';

class CheckboxField extends StatelessWidget {
  const CheckboxField({
    required this.value,
    required this.onChanged,
    required this.labelText,
    this.isError,
    super.key,
  });

  final bool? isError;
  final bool value;
  final String labelText;
  final void Function({bool? value}) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: 24,
      ),
      child: InkWell(
        onTap: () => onChanged(value: !value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              labelText,
              style: theme.textTheme.bodyLarge,
            ),
            IgnorePointer(
              child: Checkbox(
                isError: isError ?? false,
                visualDensity: const VisualDensity(
                  horizontal: VisualDensity.minimumDensity,
                  vertical: VisualDensity.minimumDensity,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: value,
                onChanged: (value) => onChanged(value: value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
