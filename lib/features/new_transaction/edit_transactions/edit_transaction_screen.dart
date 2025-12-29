import 'package:fintrack/models/transaction_items.dart';
import 'package:fintrack/features/new_transaction/widgets/base_lable_row_widget.dart';
import 'package:fintrack/providers/navigation_service.dart';
import 'package:fintrack/providers/new_transaction_provider.dart';
import 'package:fintrack/providers/transaction_form_notifier.dart';
import 'package:fintrack/features/new_transaction/widgets/base_dropdown_field.dart';
import 'package:fintrack/features/new_transaction/widgets/base_text_field.dart';
import 'package:fintrack/features/new_transaction/edit_transactions/widgets/inline_date_field.dart';
import 'package:fintrack/features/new_transaction/edit_transactions/widgets/inline_time_picker.dart';
import 'package:fintrack/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditTransaction extends ConsumerStatefulWidget {
  const EditTransaction({
    super.key,
    required this.transaction,
  required this.tkey,
  });
  final Transactions transaction;
  final dynamic tkey;

  @override
  ConsumerState<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends ConsumerState<EditTransaction> {
  Widget _buildHeader(void Function(BuildContext) onPressed) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ),
        ),
        Expanded(child: Center(child: Text('Edit'))),
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                onPressed(context);
              },
              child: Text('Save'),
            ),
          ),
        ),
      ],
    );
  }

  late final TextEditingController titleController;
  late final TextEditingController amountController;
  late final TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.transaction.title);
    amountController = TextEditingController(
      text: widget.transaction.amount.toString(),
    );
    noteController = TextEditingController(text: widget.transaction.note);

    Future.microtask(() {
      final editNotifier = ref.read(transactionFormProvider.notifier);
      editNotifier.setTitle(widget.transaction.title);
      editNotifier.setAmount(widget.transaction.amount.toString());
      editNotifier.setNote(widget.transaction.note);
      editNotifier.setType(widget.transaction.type);
      editNotifier.setMethod(widget.transaction.method);
      editNotifier.setExpenseCategory(widget.transaction.expenseCategory);
      editNotifier.setIncomeCategory(widget.transaction.incomesCategory);
      editNotifier.setDate(widget.transaction.dateTime);
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editNotifier = ref.read(transactionFormProvider.notifier);
    final formState = ref.watch(transactionFormProvider);
    final navigationService = ref.read(navigationProvider);

    final height = SizedBox(height: 20);

    final isIncome = formState.type == TransactionType.incomesCategory;
    final categories =
        isIncome ? IncomesCategory.values : ExpenseCategory.values;

    void saveEdited() {
       final enteredAmount = double.tryParse(formState.amount);

      if (formState.title.isEmpty ||
          enteredAmount == null ||
          enteredAmount <= 0 
          ) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill all required fields')),
        );
        return;
      }
      final form = ref.read(transactionFormProvider);
   
    ref
          .read(newTransactionProvider.notifier)
          .editTransaction(
            widget.tkey,
            Transactions(
              id: widget.transaction.id,
              amount: enteredAmount,
              title: form.title,
              expenseCategory: form.expenseCategory,
              incomesCategory: form.incomesCategory,
              dateTime: form.dateTime!,
              note: form.note,
              type: form.type!,
              method: form.method!,
            ),
          );
      editNotifier.reset();
      navigationService.pop();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader((context) {
                saveEdited();
              }),
              height,
              LabelRowWidget(
                label: 'Title',
                field: BaseTextField(
                  controller: titleController,
                  onChanged: (value) {
                    editNotifier.setTitle(value);
                  },
                  keyboardType: TextInputType.text,
                  label: '',
                ),
              ),
              height,
              LabelRowWidget(
                label: 'Amount',
                field: BaseTextField(
                  controller: amountController,
                  onChanged: (value) {
                    editNotifier.setAmount(value);
                  },
                  keyboardType: TextInputType.number,
                  label: '',
                ),
              ),
              height,
              LabelRowWidget(
                label: 'Category',
                field: BaseDropdownField(
                  value:
                      isIncome
                          ? formState.incomesCategory
                          : formState.expenseCategory,
                  items:
                      categories
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Text(c.readable),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (isIncome) {
                      editNotifier.setIncomeCategory(value as IncomesCategory);
                    } else {
                      editNotifier.setExpenseCategory(value as ExpenseCategory);
                    }
                  },
                ),
              ),
              height,

              LabelRowWidget(
                label: 'Account',
                field: BaseDropdownField(
                  value: formState.method,
                  items:
                      TransactionMethod.values
                          .map(
                            (m) => DropdownMenuItem(
                              value: m,
                              child: Text(m.readable),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    editNotifier.setMethod(value as TransactionMethod);
                  },
                ),
              ),
              height,
              LabelRowWidget(
                label: 'Date',
                field: InlineDatePicker(
                  onChanged: (value) {
                    editNotifier.setDate(value);
                  },
                 // index: widget.index,
                  transaction: widget.transaction,
                ),
              ),

              height,
              LabelRowWidget(
                label: 'Transaction Time',
                field: InlineTimePicker(
                  transaction: widget.transaction,
                  onChanged: (value) {
                    editNotifier.setDate(value);
                  },
                ),
              ),
              height,
              BaseTextField(
                label: 'Note',
                onChanged: (value) {
                  editNotifier.setNote(value);
                },
                controller: noteController,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
