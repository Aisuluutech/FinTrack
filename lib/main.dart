import 'package:fintrack/models/transaction_items.dart';
import 'package:fintrack/features/home/presentation/start_screen.dart';
import 'package:fintrack/providers/navigation_service.dart';
import 'package:fintrack/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TransactionsAdapter());
  Hive.registerAdapter(TransactionMethodAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(ExpenseCategoryAdapter());
  Hive.registerAdapter(IncomesCategoryAdapter());

  await Hive.openBox<Transactions>('transactionBox');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = ref.read(navigationProvider);
    return MaterialApp(
      navigatorKey: navigationService.navigatorKey,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
       home: const StartScreen(),
    );
  }
}
