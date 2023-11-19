import 'dart:io';

import 'package:app/src/features/task/presentation/widgets/simple_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../config/app_colors.dart';

class DateTimeField extends StatefulWidget {
  const DateTimeField({
    required this.labelText,
    required this.onChanged,
    this.initialValue,
    this.startDate,
    this.lastDate,
    this.errorText,
    super.key,
  });

  final String labelText;
  final String? errorText;
  final DateTime? initialValue;
  final DateTime? startDate;
  final DateTime? lastDate;
  final void Function(DateTime value) onChanged;

  @override
  State<DateTimeField> createState() => _DateTimeFieldState();
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _DateTimeFieldState extends State<DateTimeField> {
  final _dateFormat = DateFormat('dd.MM.yyyy');
  final _controller = TextEditingController();
  final _focusNode = AlwaysDisabledFocusNode();

  @override
  void initState() {
    final initialValue = widget.initialValue;

    if (initialValue != null) {
      final formatted = _dateFormat.format(initialValue);

      _controller.text = formatted;
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SimpleField(
      controller: _controller,
      focusNode: _focusNode,
      readOnly: true,
      labelText: widget.labelText,
      errorText: widget.errorText,
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
      //suffixIcon: Icon(Icons.calendar_month,),
      onTap: () async {
        final pickedDate = await _showDatePicker(
          context: context,
        );

        if (pickedDate != null) {
          final formatted = _dateFormat.format(pickedDate);

          _controller.text = formatted;

          widget.onChanged(pickedDate);
        }
      },
    );
  }

  Future<DateTime?> _showDatePicker({
    required BuildContext context,
  }) async {
    final firstDate = widget.startDate ?? DateTime(1900);
    final lastDate = widget.lastDate ?? DateTime.now();
    final initialDate = lastDate.subtract(const Duration(days: 1));

    if (Platform.isIOS) {
      final pickedDate = await showCupertinoModalPopup<DateTime?>(
        context: context,
        builder: (_) => CupertinoDatePickerDialog(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
        ),
      );

      return pickedDate;
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    return pickedDate;
  }
}

class CupertinoDatePickerDialog extends StatefulWidget {
  const CupertinoDatePickerDialog({
    required this.firstDate,
    required this.lastDate,
    required this.initialDate,
    super.key,
  });

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime initialDate;

  @override
  State<CupertinoDatePickerDialog> createState() =>
      _CupertinoDatePickerDialogState();
}

class _CupertinoDatePickerDialogState extends State<CupertinoDatePickerDialog> {
  DateTime? _pickedDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 300,
      // The Bottom margin is provided to align the popup above the system
      // navigation bar.
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      // Provide a background color for the popup.
      color: CupertinoColors.systemBackground.resolveFrom(context),
      // Use a SafeArea widget to avoid system overlaps.
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  minimumDate: widget.firstDate,
                  maximumDate: widget.lastDate,
                  initialDateTime: widget.initialDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      _pickedDate = newDate;
                    });
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_pickedDate == null) {
                    setState(() {
                      _pickedDate =
                          DateTime.now().subtract(const Duration(days: 1));
                    });
                  }
                  Navigator.of(context).pop(_pickedDate);
                },
                child: Text(
                  'Выберите дату',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
