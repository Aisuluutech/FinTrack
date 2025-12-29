import 'package:fintrack/features/filter/filter_state.dart';
import 'package:fintrack/models/transaction_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterNotifier extends Notifier<FilterState> {
  @override
  FilterState build() {
    return FilterState();
  }

  void setMethod(TransactionMethod? method) {
    state = state.copyWith(method: method);
  }

  void setType(TransactionType? type) {
    state = state.copyWith(type: type);
  }

  void setFromDate(DateTime? fromDate) {
    state = state.copyWith(fromDate: fromDate);
  }

  void setToDate(DateTime? toDate) {
    state = state.copyWith(toDate: toDate);
  }

  void reset() {
    state = FilterState(
      method: null, 
      type: null, 
      fromDate: null, 
      toDate: null);
  }
}

final filterProvider = NotifierProvider<FilterNotifier, FilterState>(
  FilterNotifier.new,
);
