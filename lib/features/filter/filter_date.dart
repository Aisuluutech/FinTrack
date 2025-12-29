import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class FilterDatePicker extends ConsumerWidget {
  const FilterDatePicker({
    super.key,
    required this.label,
    required this.text,
    required this.onSelected,
    this.selectedDate,
  });

  final String text;
  final String label;
  final DateTime? selectedDate;
  final void Function(DateTime) onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        final now = DateTime.now();
        final date = await showDatePicker(
          context: context,
          firstDate: DateTime(now.year - 5),
          lastDate: now,
          initialDate: selectedDate ?? now,
        );

        if (date != null) {
          final finalDate =
              label.toLowerCase().contains("to")
                  ? DateTime(date.year, date.month, date.day, 23, 59, 59)
                  : date;

          onSelected(finalDate);
        }
      },

      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.secondaryContainer
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(text),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label),
                const SizedBox(width: 8),
                const Icon(Icons.date_range_sharp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
