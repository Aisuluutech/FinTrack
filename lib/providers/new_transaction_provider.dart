import 'package:fintrack/models/transaction_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NewTransactionNotifier extends Notifier<List<Transactions>> {
  late Box<Transactions> _box;

  @override
  List<Transactions> build() {
    _box = Hive.box<Transactions>('transactionBox');

    _box.listenable().addListener(() {
      state = _box.values.toList();
    });

    return _box.values.toList();
  }

  void addTransaction(Transactions tx) {
    _box.add(tx); 
  }

  void editTransaction(dynamic key, Transactions updated) {
    _box.put(key, updated); 
    
  }

  void removeAtIndex(int index) {
    _box.deleteAt(index); 
  }
}

final newTransactionProvider =
    NotifierProvider<NewTransactionNotifier, List<Transactions>>(
  NewTransactionNotifier.new,
);


