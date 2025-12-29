import 'package:fintrack/models/transaction_items.dart';
import 'package:fintrack/providers/navigation_service.dart';
import 'package:fintrack/providers/new_transaction_provider.dart';
import 'package:fintrack/features/new_transaction/widgets/base_dropdown_field.dart';
import 'package:fintrack/features/new_transaction/widgets/base_text_field.dart';
import 'package:fintrack/providers/transaction_form_notifier.dart';
import 'package:fintrack/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AddTransaction extends ConsumerStatefulWidget {
  const AddTransaction({super.key});

  @override
  ConsumerState<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends ConsumerState<AddTransaction> {
  void _presentDatePicker() async {
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
      initialDate: now,
    );

    if (pickedDate == null) return;

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    final fullDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    ref.read(addTransactionFormProvider.notifier).setDate(fullDateTime);
  }

  @override
  Widget build(BuildContext context) {


    final formState = ref.watch(addTransactionFormProvider);
    final formNotifier = ref.read(addTransactionFormProvider.notifier);

    final isIncome = formState.type == TransactionType.incomesCategory;
    final categories =
        isIncome ? IncomesCategory.values : ExpenseCategory.values;

    final navigationService = ref.read(navigationProvider);

    void submitTransaction() {
      final enteredAmount = double.tryParse(formState.amount);

      if (formState.title.isEmpty ||
          enteredAmount == null ||
          enteredAmount <= 0 ||
          formState.dateTime == null ||
          formState.method == null ||
          formState.type == null ||
          (formState.type == TransactionType.incomesCategory &&
              formState.incomesCategory == null) ||
          (formState.type == TransactionType.expenseCategory &&
              formState.expenseCategory == null)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all required fields')),
        );
        return;
      }

      ref
          .read(newTransactionProvider.notifier)
          .addTransaction(
            Transactions(
              title: formState.title,
              amount: enteredAmount,
              note: formState.note,
              dateTime: formState.dateTime!,
              type: formState.type!,
              method: formState.method!,
              incomesCategory: formState.incomesCategory,
              expenseCategory: formState.expenseCategory,
            ),
          );
      formNotifier.reset();

      navigationService.pop();
    }

    return Column(
      children: [
        BaseTextField(
          label: 'title',
          onChanged: (value) {
            formNotifier.setTitle(value);
          },
          keyboardType: TextInputType.multiline,
          maxLines: 2,
        ),
        SizedBox(height: 10),
        BaseTextField(
          label: 'Amount',
          onChanged: (value) {
            formNotifier.setAmount(value);
          },
          keyboardType: TextInputType.number,
        ),

        SizedBox(height: 10),
        BaseDropdownField(
          value:
              isIncome ? formState.incomesCategory : formState.expenseCategory,
          items:
              categories
                  .map(
                    (c) => DropdownMenuItem(
                      value: c,
                      child: Text(
                        c.readable,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            if (isIncome) {

              formNotifier.setIncomeCategory(value as IncomesCategory);
            } else {
            
              formNotifier.setExpenseCategory(value as ExpenseCategory);
            }
          },
          hint: 'Category',
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 100,
          padding: EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.date_range_rounded),
                    SizedBox(width: 10),
                    Text('Date', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    formState.dateTime == null
                        ? 'No date selected'
                        : formatter.format(formState.dateTime!),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        BaseTextField(
          label: 'Note',
          onChanged: (value) {
            formNotifier.setNote(value);
          },
          keyboardType: TextInputType.multiline,
          hintText: 'Optional',
        ),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            onPressed: () {
              submitTransaction();
            },
            child: Text(
              'Save Transaction',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
