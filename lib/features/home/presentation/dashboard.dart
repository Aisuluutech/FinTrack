import 'package:fintrack/models/transaction_items.dart';
import 'package:fintrack/features/new_transaction/add_transactions/add_transaction_screen.dart';
import 'package:fintrack/features/filter/filter_screen.dart';
import 'package:fintrack/providers/filter_state_notifier.dart';
import 'package:fintrack/providers/filterd_transactions_provider.dart';
import 'package:fintrack/providers/navigation_service.dart';
import 'package:fintrack/features/new_transaction/add_transactions/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<Dashboard> {
  void reset() {
    ref.read(filterProvider.notifier).reset();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(filterProvider);
    final filteredlist =
        filter.method != null ||
        filter.type != null ||
        filter.fromDate != null ||
        filter.toDate != null;

    final transactions = ref.watch(filteredTransactionsProvider)
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

    final mainContent =
        transactions.isEmpty
            ? Center(
              child: Text(
                'No transactions found. Start adding some!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
            : TransactionList(transactions: transactions);

    final navigationService = ref.read(navigationProvider);



  final totalIncome = transactions
    .where((t) => t.type == TransactionType.incomesCategory)
    .fold<double>(0, (sum, t) => sum + t.amount);

final totalExpense = transactions
    .where((t) => t.type == TransactionType.expenseCategory)
    .fold<double>(0, (sum, t) => sum + t.amount);

final balance = totalIncome - totalExpense;


    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Budget', ),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  navigationService.push(
                    AddTransactionScreen(),
                  );
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
          decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Theme.of(context).colorScheme.primaryContainer.withAlpha(200),
        Theme.of(context).colorScheme.surface,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withAlpha(200),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  child: Row(
                    children: [
                      Text(
                        "Transactions",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Spacer(),
                      TextButton.icon(
                        onPressed: () {
                          navigationService.push(FilterScreen());
                        },
                        icon: Icon(
                          Icons.filter_alt,
                          color:
                              filteredlist
                                  ? Theme.of(
                                    context,
                                  ).colorScheme.inverseSurface
                                  : Theme.of(context).colorScheme.primary,
                        ),
                        label: Text(""),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          reset();
                        },
                        icon: Icon(Icons.filter_alt_off),
                        label: Text(""),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: mainContent),
            ],
          ),
        ),
    //  ),
      bottomNavigationBar: BottomAppBar(
         color: Theme.of(context).colorScheme.inversePrimary,
        height: 70,
        child: Column(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Total Income: $totalIncome'),
                Text('Total Expense: $totalExpense'),
              ],
            ),
            Text('Balance: $balance'),
          ],
        ),
      ),
    );
  }
}
