import 'package:fintrack/features/filter/filter_date.dart';
import 'package:fintrack/models/transaction_items.dart';
import 'package:fintrack/features/new_transaction/widgets/base_dropdown_field.dart';
import 'package:fintrack/providers/filter_state_notifier.dart';
import 'package:fintrack/providers/navigation_service.dart';
import 'package:fintrack/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  final height = SizedBox(height: 40);

  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(filterProvider);
    final filterNotifier = ref.read(filterProvider.notifier);
    final navigationService = ref.read(navigationProvider);
    final now = DateTime.now();
    final formatter = DateFormat.yMd();

    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BaseDropdownField(
              value: filterState.method,
              items:
                  TransactionMethod.values
                      .map(
                        (m) => DropdownMenuItem(
                          value: m,
                          child: Text(
                            m.readable,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                filterNotifier.setMethod(value);
              },
              hint: 'Account',
            ),
            height,
            BaseDropdownField(
              value: filterState.type,
              items:
                  TransactionType.values
                      .map(
                        (m) => DropdownMenuItem(
                          value: m,
                          child: Text(
                            m.text,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                filterNotifier.setType(value);
              },
              hint: 'Type',
            ),

            height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterDatePicker(
                  text: 'From',
                  label: formatter.format(
                    filterState.fromDate ?? now.subtract(Duration(days: 7)),
                  ),
                  selectedDate: filterState.fromDate,
                  onSelected: (date) => filterNotifier.setFromDate(date),
                ),
                FilterDatePicker(
                  text: 'To',
                  label: formatter.format(filterState.toDate ?? now),
                  selectedDate: filterState.toDate,
                  onSelected: (date) => filterNotifier.setToDate(date),
                ),
              ],
            ),
            height,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                onPressed: () {
                  navigationService.pop();
                },
                child: Text(
                  'Apply',
                  style: Theme.of(context).textTheme.bodyLarge,

                ),
              ),
            ),
            height,
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                onPressed: () {
                  ref.read(filterProvider.notifier).reset();
                },
                child: Text(
                  'Reset',
                  style: Theme.of(context).textTheme.bodyLarge,))
          ],
        ),
      ),
    );
  }
}
