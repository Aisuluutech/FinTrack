import 'package:fintrack/models/transaction_items.dart';
import 'package:fintrack/core/extensions/string_extension.dart';
import 'package:fintrack/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionItem extends ConsumerWidget {
  const TransactionItem({
    super.key,
    required this.transactions,
    required this.index,
  });

  final Transactions transactions;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isIncome = transactions.type == TransactionType.incomesCategory;
    final iconsName = isIncome
                        ? transactions.incomesCategory?.readable ?? ''
                        : transactions.expenseCategory?.readable ?? '';

    IconData getTransactionIcon(Transactions tx) {
      if (tx.type == TransactionType.incomesCategory) {
        return incomesCategoryIcons[tx.incomesCategory] ?? Icons.attach_money;
      } else if (tx.type == TransactionType.expenseCategory) {
        return expenseCategoryIcons[tx.expenseCategory] ?? Icons.shopping_cart;
      } else {
        return Icons.help_outline;
      }
    }

    final date = DateFormat.yMMMd().format(transactions.dateTime);
    final timeOfDay = TimeOfDay(
      hour: transactions.dateTime.hour,
      minute: transactions.dateTime.minute,
    );
    final formattedTime = MaterialLocalizations.of(
      context,
    ).formatTimeOfDay(timeOfDay);

    return Card(
      color: Theme.of(context).colorScheme.surface,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 14, 14, 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Column(
                children: [
                  Icon(
                    getTransactionIcon(transactions),
                    size: 28,
                    color:
                        isIncome ? incomeColor(context) : expenseColor(context),
                  ),
                  const SizedBox(height: 4),
                  Text(iconsName,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transactions.title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    transactions.method.readable,
                    style: Theme.of(context).textTheme.bodySmall
                  ),
                  if (transactions.note.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      transactions.note,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transactions.amount}',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color:
                        isIncome ? incomeColor(context) : expenseColor(context),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$date $formattedTime',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



