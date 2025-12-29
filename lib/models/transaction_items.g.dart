// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_items.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionsAdapter extends TypeAdapter<Transactions> {
  @override
  final int typeId = 1;

  @override
  Transactions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transactions(
      id: fields[0] as String?,
      amount: fields[1] as double,
      title: fields[2] as String,
      dateTime: fields[5] as DateTime,
      note: fields[6] as String,
      type: fields[7] as TransactionType,
      method: fields[8] as TransactionMethod,
      incomesCategory: fields[4] as IncomesCategory?,
      expenseCategory: fields[3] as ExpenseCategory?,
    );
  }

  @override
  void write(BinaryWriter writer, Transactions obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.expenseCategory)
      ..writeByte(4)
      ..write(obj.incomesCategory)
      ..writeByte(5)
      ..write(obj.dateTime)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.method);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionMethodAdapter extends TypeAdapter<TransactionMethod> {
  @override
  final int typeId = 2;

  @override
  TransactionMethod read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionMethod.cash;
      case 1:
        return TransactionMethod.card;
      default:
        return TransactionMethod.cash;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionMethod obj) {
    switch (obj) {
      case TransactionMethod.cash:
        writer.writeByte(0);
        break;
      case TransactionMethod.card:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionMethodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionTypeAdapter extends TypeAdapter<TransactionType> {
  @override
  final int typeId = 3;

  @override
  TransactionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionType.expenseCategory;
      case 1:
        return TransactionType.incomesCategory;
      default:
        return TransactionType.expenseCategory;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionType obj) {
    switch (obj) {
      case TransactionType.expenseCategory:
        writer.writeByte(0);
        break;
      case TransactionType.incomesCategory:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExpenseCategoryAdapter extends TypeAdapter<ExpenseCategory> {
  @override
  final int typeId = 4;

  @override
  ExpenseCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseCategory.restaurants;
      case 1:
        return ExpenseCategory.clothing;
      case 2:
        return ExpenseCategory.health;
      case 3:
        return ExpenseCategory.household;
      case 4:
        return ExpenseCategory.food;
      case 5:
        return ExpenseCategory.entertainment;
      default:
        return ExpenseCategory.restaurants;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseCategory obj) {
    switch (obj) {
      case ExpenseCategory.restaurants:
        writer.writeByte(0);
        break;
      case ExpenseCategory.clothing:
        writer.writeByte(1);
        break;
      case ExpenseCategory.health:
        writer.writeByte(2);
        break;
      case ExpenseCategory.household:
        writer.writeByte(3);
        break;
      case ExpenseCategory.food:
        writer.writeByte(4);
        break;
      case ExpenseCategory.entertainment:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IncomesCategoryAdapter extends TypeAdapter<IncomesCategory> {
  @override
  final int typeId = 5;

  @override
  IncomesCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return IncomesCategory.salary;
      case 1:
        return IncomesCategory.investments;
      case 2:
        return IncomesCategory.gifts;
      case 3:
        return IncomesCategory.interest;
      case 4:
        return IncomesCategory.sideJob;
      case 5:
        return IncomesCategory.profit;
      default:
        return IncomesCategory.salary;
    }
  }

  @override
  void write(BinaryWriter writer, IncomesCategory obj) {
    switch (obj) {
      case IncomesCategory.salary:
        writer.writeByte(0);
        break;
      case IncomesCategory.investments:
        writer.writeByte(1);
        break;
      case IncomesCategory.gifts:
        writer.writeByte(2);
        break;
      case IncomesCategory.interest:
        writer.writeByte(3);
        break;
      case IncomesCategory.sideJob:
        writer.writeByte(4);
        break;
      case IncomesCategory.profit:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IncomesCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
