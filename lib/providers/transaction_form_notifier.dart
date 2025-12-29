import 'package:fintrack/models/transaction_items.dart';
import 'package:fintrack/features/new_transaction/edit_transactions/state/transaction_form_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionFormNotifier extends Notifier<TransactionFormState> {
  TransactionFormNotifier();

  @override
  TransactionFormState build() {
    return TransactionFormState();
  }

  void setTitle(String value) => state = state.copyWith(title: value);
  void setAmount(String value) => state = state.copyWith(amount: value);
  void setNote(String value) => state = state.copyWith(note: value);
  void setDate(DateTime date) => state = state.copyWith(dateTime: date);
  void setIncomeCategory(IncomesCategory? value) =>
      state = state.copyWith(incomesCategory: value);
  void setExpenseCategory(ExpenseCategory? value) =>
      state = state.copyWith(expenseCategory: value);
  void setType(TransactionType? value) => state = state.copyWith(type: value);
  void setMethod(TransactionMethod? value) =>
      state = state.copyWith(method: value);

  void reset() =>
      state = TransactionFormState(
        title: '',
        amount: '',
        note: '',
        dateTime: null,
        type: null,
        incomesCategory: null,
        expenseCategory: null,
        method: null,
      );
}

final transactionFormProvider =
    NotifierProvider<TransactionFormNotifier, TransactionFormState>(
      TransactionFormNotifier.new,
    );
final addTransactionFormProvider =
    NotifierProvider<TransactionFormNotifier, TransactionFormState>(
      TransactionFormNotifier.new,
    );
