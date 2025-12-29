import 'package:fintrack/providers/filter_state_notifier.dart';
import 'package:fintrack/providers/new_transaction_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredTransactionsProvider = Provider((ref) {
  final list = ref.watch(newTransactionProvider);
  final f = ref.watch(filterProvider);

  return list.where((tx) {
    final txDate = DateTime(
      tx.dateTime.year,
      tx.dateTime.month,
      tx.dateTime.day,
    );
    final fromDate =
        f.fromDate != null
            ? DateTime(f.fromDate!.year, f.fromDate!.month, f.fromDate!.day)
            : null;
    final toDate =
        f.toDate != null
            ? DateTime(f.toDate!.year, f.toDate!.month, f.toDate!.day)
            : null;

    final okDate =
        (fromDate == null || !txDate.isBefore(fromDate)) &&
        (toDate == null || !txDate.isAfter(toDate));

    final okType = f.type == null || tx.type == f.type;
    final okMethod = f.method == null || tx.method == f.method;

    return okDate && okType && okMethod;
  }).toList();
});


