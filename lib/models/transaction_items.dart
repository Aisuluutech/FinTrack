import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
part 'transaction_items.g.dart';


final formatter = DateFormat.yMd();
final uuid = Uuid();

@HiveType(typeId: 1)
class Transactions extends HiveObject {
  Transactions({
    String? id,
    required this.amount,
    required this.title,
    required this.dateTime,
    required this.note,
    required this.type,
    required this.method,
    this.incomesCategory,
    this.expenseCategory,
  }) : id = id ?? uuid.v4();

  @HiveField(0)
  final String id;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final ExpenseCategory? expenseCategory;
  @HiveField(4)
  final IncomesCategory? incomesCategory;
  @HiveField(5)
  final DateTime dateTime;
  @HiveField(6)
  final String note;
  @HiveField(7)
  final TransactionType type;
  @HiveField(8)
  final TransactionMethod method;
 

  String get formattedDate {
    return formatter.format(dateTime);
  }

  Transactions copyWith({
    double? amount,
    String? title,
    ExpenseCategory? expenseCategory,
    IncomesCategory? incomesCategory,
    DateTime? dateTime,
    String? note,
    TransactionType? type,
    TransactionMethod? method,
  }) {
    return Transactions(
      id: id,
      amount: amount ?? this.amount,
      title: title ?? this.title,
      expenseCategory: expenseCategory ?? this.expenseCategory,
      incomesCategory: incomesCategory ?? this.incomesCategory,
      dateTime: dateTime ?? this.dateTime,
      note: note ?? this.note,
      type: type ?? this.type,
      method: method ?? this.method, 
    );
  }
}

@HiveType(typeId: 2)
enum TransactionMethod {
  @HiveField(0)
  cash,
  @HiveField(1)
  card,
}

@HiveType(typeId: 3)
enum TransactionType {
  @HiveField(0)
  expenseCategory,
  @HiveField(1)
  incomesCategory,
}

@HiveType(typeId: 4)
enum ExpenseCategory {
  @HiveField(0)
  restaurants,
  @HiveField(1)
  clothing,
  @HiveField(2)
  health,
  @HiveField(3)
  household,
  @HiveField(4)
  food,
  @HiveField(5)
  entertainment,
}

const expenseCategoryIcons = {
  ExpenseCategory.restaurants: FontAwesomeIcons.utensils,
  ExpenseCategory.clothing: FontAwesomeIcons.shirt,
  ExpenseCategory.health: FontAwesomeIcons.briefcaseMedical,
  ExpenseCategory.household: FontAwesomeIcons.house,
  ExpenseCategory.food: FontAwesomeIcons.cartShopping,
  ExpenseCategory.entertainment: FontAwesomeIcons.film,
};

@HiveType(typeId: 5)
enum IncomesCategory {
  @HiveField(0)
  salary,
  @HiveField(1)
  investments,
  @HiveField(2)
  gifts,
  @HiveField(3)
  interest,
  @HiveField(4)
  sideJob,
  @HiveField(5)
  profit,
}

const incomesCategoryIcons = {
  IncomesCategory.salary: FontAwesomeIcons.moneyCheckDollar,
  IncomesCategory.investments: FontAwesomeIcons.chartLine,
  IncomesCategory.gifts: FontAwesomeIcons.gift,
  IncomesCategory.interest: FontAwesomeIcons.piggyBank,
  IncomesCategory.sideJob: FontAwesomeIcons.briefcase,
  IncomesCategory.profit: FontAwesomeIcons.coins,
};


