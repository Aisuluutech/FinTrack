
import 'package:fintrack/models/transaction_items.dart';

extension Capitalize on String {
  String get capitalized =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);
}

extension EnumReadable on Enum {
  String get readable {
    final name = this.name;
    final separated = name.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => ' ${match.group(1)!.toLowerCase()}',
    );
    return separated.trim().capitalized;
  }
}

extension TransactionTypeExtension on TransactionType {
  String get text {
    switch (this) {
      case TransactionType.incomesCategory:
        return 'Incomes';
      case TransactionType.expenseCategory:
        return 'Expenses';
    }
  }
}