import 'package:fintrack/models/transaction_items.dart';
import 'package:fintrack/providers/transaction_form_notifier.dart';
import 'package:fintrack/features/new_transaction/edit_transactions/widgets/base_date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InlineDatePicker extends ConsumerStatefulWidget {
  const InlineDatePicker({
    super.key,
    required this.transaction,
   // required this.index,
    required this.onChanged
  });

  final Transactions transaction;
 // final int index;
  final void Function(DateTime) onChanged;

  @override
  ConsumerState<InlineDatePicker> createState() => _InlineDatePickerState();
}

class _InlineDatePickerState extends ConsumerState<InlineDatePicker> {
  bool showPicker = false;

  final List<int> days = List.generate(31, (i) => i + 1);
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  final List<int> years = List.generate(201, (i) => 1900 + i);

  void _updateSelectedDate({int? day, int? month, int? year}) {
   final form = ref.read(transactionFormProvider);
   final old = form.dateTime!;

   final newDate = DateTime(
    year ?? old.year,
    month ?? old.month,
    day ?? old.day,
    old.hour,
    old.minute
   );
        ref.read(transactionFormProvider.notifier).setDate(newDate);
        widget.onChanged(newDate);
       
  }

  @override
  Widget build(BuildContext context) {
    final formDate = ref.watch(transactionFormProvider);
    if (formDate.dateTime == null) {
      return SizedBox();
    }

    final date = formDate.dateTime!;
    final currentDay = date.day;
    final currentMonth = months[date.month - 1];
    final currentYear = date.year;
    
   
    return GestureDetector(
      onTap: () => setState(() => showPicker = !showPicker),
      child: showPicker
          ? Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                height: 80,
                child: Row(
                  children: [
                    BaseDateTimePicker(
                      items: days,
                      selected: currentDay,
                      onSelect: (v) {
                       _updateSelectedDate(day: v);
                      },
                    ),
                    BaseDateTimePicker(
                      items: months,
                      selected: currentMonth,
                      onSelect: (v) {
                       
                     final monthIndex = months.indexOf(v) + 1;
                        _updateSelectedDate(month: monthIndex);
                      },
                    ),
                    BaseDateTimePicker(
                      items: years,
                      selected: currentYear,
                      onSelect: (v) {
                       _updateSelectedDate(year: v);
                      },
                    ),
                  ],
                ),
              ),
            )
          : Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "$currentDay $currentMonth $currentYear",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
    );
  }
}
