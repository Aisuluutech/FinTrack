import 'package:fintrack/features/new_transaction/add_transactions/add_transaction_form.dart';
import 'package:fintrack/models/transaction_items.dart';
import 'package:fintrack/providers/transaction_form_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});
  
  @override
  ConsumerState<AddTransactionScreen> createState() => _ChooseTransactionState();
}

class _ChooseTransactionState extends ConsumerState<AddTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(addTransactionFormProvider);
     final formNotifier = ref.read(addTransactionFormProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                label: 'Cash',
                selected: formState.method == TransactionMethod.cash,
                onTap: () {
                 formNotifier.setMethod(TransactionMethod.cash);
                },
                left: true,
              ),

              _buildButton(
                label: 'Card',
                selected: formState.method == TransactionMethod.card,
                onTap: () {
                formNotifier.setMethod(TransactionMethod.card);
                },
                right: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                label: 'Incomes',
                selected: formState.type == TransactionType.incomesCategory,
                onTap: () {
                 formNotifier.setType(TransactionType.incomesCategory);
                 formNotifier.setExpenseCategory(null);
                },
                left: true,
              ),
              _buildButton(
                label: 'Expenses',
                selected: formState.type == TransactionType.expenseCategory,
                onTap: () {
                   formNotifier.setType(TransactionType.expenseCategory);
                   formNotifier.setIncomeCategory(null);
                },
                right: true,
              ),
            ],
          ),

          const SizedBox(height: 20),
          AddTransaction(),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required bool selected,
    required void Function() onTap,
    bool left = false,
    bool right = false,
  }) {
    return Expanded(
      child: Container(
       // width: 200,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(
            left: left ? const Radius.circular(15) : Radius.zero,
            right: right ? const Radius.circular(15) : Radius.zero,
          ),
          color:
              selected
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: Text(label, style: 
            Theme.of(context).textTheme.bodyLarge)
           
          ),
        ),
      ),
    );
  }
}
