import 'package:fintrack/models/transaction_items.dart';

class TransactionFormState {
  TransactionFormState({
    this.amount = '',
    this.title = '',
    this.expenseCategory,
    this.incomesCategory,
    this.dateTime,
    this.note = '',
    this.type,
    this.method,
  });

  final String amount;
  final String title;
  final ExpenseCategory? expenseCategory;
  final IncomesCategory? incomesCategory;
  final DateTime? dateTime;
  final String note;
  final TransactionType? type;
  final TransactionMethod? method;

  TransactionFormState copyWith({
    String? title,
    String? amount,
    String? note,
    DateTime? dateTime,
    IncomesCategory? incomesCategory,
    ExpenseCategory? expenseCategory,
    TransactionType? type,
    TransactionMethod? method,
  }) {
    return TransactionFormState(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      dateTime: dateTime ?? this.dateTime,
      incomesCategory: incomesCategory ?? this.incomesCategory,
      expenseCategory: expenseCategory ?? this.expenseCategory,
      type: type ?? this.type,
      method: method ?? this.method,
    );
  }
}

