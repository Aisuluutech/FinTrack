import 'package:fintrack/models/transaction_items.dart';
import 'package:fintrack/providers/transaction_form_notifier.dart';
import 'package:fintrack/features/new_transaction/edit_transactions/widgets/base_date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InlineTimePicker extends ConsumerStatefulWidget {
  const InlineTimePicker({
    super.key,
    required this.transaction,
    required this.onChanged,
  });
 
  final Transactions transaction;
  final void Function(DateTime) onChanged;

  @override
  ConsumerState<InlineTimePicker> createState() => _InlineDatePickerState();
}

class _InlineDatePickerState extends ConsumerState<InlineTimePicker> {
  
  final List<int> hour = List.generate(24, (i) => i);
  final List<int> minute = List.generate(60, (i) => i);
  bool showPicker = false;

  void _updateSelectedTime({int? hour, int? minute}) {
    final form = ref.read(transactionFormProvider);
    final old = form.dateTime!;

    final newTime = DateTime(
      old.year,
      old.month,
      old.day,
      hour ?? old.hour, 
      minute ?? old.minute
      );
    ref.read(transactionFormProvider.notifier).setDate(newTime);
    widget.onChanged(newTime);
  }


  @override
  Widget build(BuildContext context) {
    final formTime = ref.watch(transactionFormProvider);
    if (formTime.dateTime == null) {
      return SizedBox();
    }

    final time = formTime.dateTime!;
    final currentHour = time.hour;
    final currentMinute = time.minute;

    final timeOfDay = TimeOfDay(hour: currentHour, minute: currentMinute);
final formatted = MaterialLocalizations.of(context).formatTimeOfDay(timeOfDay);


    return GestureDetector(
      onTap: () {
        setState(() {
          showPicker = !showPicker;
        });
      },
      child:
          showPicker
              ? Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 80,
                  child: Row(
                    children: [
                      BaseDateTimePicker(
                        items: hour,
                        selected: currentHour,
                        onSelect: (v) {
                          _updateSelectedTime(hour: v);
                        },
                      ),
                      BaseDateTimePicker(
                        items: minute,
                        selected: currentMinute,
                        onSelect: (v) {
                          _updateSelectedTime(minute: v);
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
                   formatted,
                   // '${currentHour.toString().padLeft(2, '0')} :  ${currentMinute.toString().padLeft(2, '0')}' ,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
    );
  }
}
