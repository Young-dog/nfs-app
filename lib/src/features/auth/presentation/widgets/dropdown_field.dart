import 'package:app/src/config/app_colors.dart';
import 'package:flutter/material.dart';

class DropdownField<T> extends StatelessWidget {
  const DropdownField({
    required this.labelText,
    required this.values,
    required this.toText,
    this.value,
    this.onChanged,
    super.key,
  });

  final T? value;
  final void Function(T? value)? onChanged;
  final String Function(T value) toText;
  final String labelText;
  final List<T> values;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final theme = Theme.of(context);

    return Column(
      children: [
        Stack(
          children: [
            DropdownButtonFormField<T>(
              elevation: 8,
              borderRadius: BorderRadius.circular(32),
              menuMaxHeight: mq.size.height / 2,
              isExpanded: true,
              iconSize: 0,
              value: value,
              onChanged: onChanged,
              style: theme.textTheme.bodyMedium,
              decoration: InputDecoration(
                fillColor: AppColors.bgPrimary,
                labelText: labelText,
                iconColor: MaterialStateColor.resolveWith(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.focused)) {
                      return AppColors.grey;
                    }

                    return AppColors.greyishBlue;
                  },
                ),
                focusedBorder: OutlineInputBorder(
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
                labelStyle: theme.textTheme.bodyLarge,
                floatingLabelStyle: theme.textTheme.bodyLarge,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
              ),
              items: _buildItems(),
              selectedItemBuilder: (context) {
                // Prevent sticking the label on the top
                Focus.of(context).unfocus();
                return _buildItems();
              },
            ),
            const Positioned(
              top: 0,
              bottom: 0,
              right: 16,
              child: Center(
                child: IgnorePointer(
                    child: Icon(Icons.arrow_drop_down_circle_outlined)),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }

  List<DropdownMenuItem<T>> _buildItems() {
    return values.map(
      (T curValue) {
        return DropdownMenuItem<T>(
          value: curValue,
          child: Text(
            toText(curValue),
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    ).toList();
  }
}
