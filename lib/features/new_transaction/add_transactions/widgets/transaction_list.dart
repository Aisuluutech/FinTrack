import 'package:fintrack/features/new_transaction/edit_transactions/edit_transaction_screen.dart';
import 'package:fintrack/models/transaction_items.dart';
import 'package:fintrack/providers/new_transaction_provider.dart';
import 'package:fintrack/features/new_transaction/add_transactions/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class TransactionList extends ConsumerStatefulWidget {
  const TransactionList({super.key, required this.transactions});
  final List<Transactions> transactions;

  @override
  ConsumerState<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends ConsumerState<TransactionList> {
  @override
  Widget build(BuildContext context) {
    void openEditModal(
      BuildContext context,
      WidgetRef ref,
      Transactions transaction,
      dynamic key,
    ) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => EditTransaction(transaction: transaction, tkey: key),
      );
    }

    final transaction = widget.transactions;

    return ListView.builder(
      primary: false,
      itemCount: transaction.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(transaction[index].id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              ref.read(newTransactionProvider.notifier).removeAtIndex(index);
            }
          },
          background: Container(
            color: const Color.fromARGB(123, 240, 22, 7),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          child: InkWell(
            onTap: () {
              final box = Hive.box<Transactions>('transactionBox');
              final txKey = box.keyAt(index); 
              final tx = box.getAt(index)!;
              openEditModal(context, ref, tx, txKey);

            },
            child: TransactionItem(
              transactions: transaction[index],
              index: index,
            ),
          ),
        );
      },
    );
  }
}
