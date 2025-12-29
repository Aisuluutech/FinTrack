import 'package:fintrack/models/transaction_items.dart';

class FilterState {
  const FilterState({this.method, this.type, this.fromDate, this.toDate});

  final TransactionMethod? method;
  final TransactionType? type;
  final DateTime? fromDate;
  final DateTime? toDate;


  FilterState copyWith({
    Object? method = _sentinel,
    Object? type = _sentinel,
    Object? fromDate = _sentinel,
    Object? toDate = _sentinel,
  }) {
    return FilterState(
      method: method == _sentinel ? this.method : method as TransactionMethod,
      type: type == _sentinel ? this.type : type as TransactionType,
      fromDate: fromDate == _sentinel ? this.fromDate : fromDate as DateTime,
      toDate: toDate == _sentinel ? this.toDate : toDate as DateTime
      
    );
    
  }
}
const _sentinel = Object();
