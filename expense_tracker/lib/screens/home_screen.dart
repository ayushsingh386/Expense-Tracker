import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_list.dart';
import '../widgets/summary_card.dart';
import '../widgets/expense_chart.dart';
import 'add_expense_screen.dart';
import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _initializeData();
      _isInit = true;
    }
  }

  Future<void> _initializeData() async {
    await Provider.of<ExpenseProvider>(context, listen: false).initialize();
  }

  void _selectPreviousMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month - 1, 1);
    });
  }

  void _selectNextMonth() {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, _selectedDate.month + 1, 1);
    });
  }

  void _addNewExpense() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddExpenseScreen(),
      ),
    );
  }

  void _openCategories() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const CategoriesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final monthlyExpenses = expenseProvider.getExpensesForMonth(
      _selectedDate.month,
      _selectedDate.year,
    );
    final totalAmount = expenseProvider.getTotalForMonth(
      _selectedDate.month,
      _selectedDate.year,
    );
    final expensesByCategory = expenseProvider.getExpensesByCategory(
      _selectedDate.month,
      _selectedDate.year,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: _openCategories,
            tooltip: 'Categories',
          ),
        ],
      ),
      body: expenseProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _initializeData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Month selector
                      Card(
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_left),
                                onPressed: _selectPreviousMonth,
                              ),
                              Text(
                                DateFormat('MMMM yyyy').format(_selectedDate),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              IconButton(
                                icon: const Icon(Icons.chevron_right),
                                onPressed: _selectNextMonth,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Summary card
                      SummaryCard(totalAmount: totalAmount),
                      const SizedBox(height: 24),
                      
                      // Expense chart
                      if (expensesByCategory.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Spending by Category',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 220,
                              child: ExpenseChart(
                                expensesByCategory: expensesByCategory,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      
                      // Expense list
                      Text(
                        'Recent Expenses',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      monthlyExpenses.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.receipt_long,
                                      size: 64,
                                      color: Theme.of(context).disabledColor,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No expenses yet',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Add your first expense by tapping the + button',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: Theme.of(context).textTheme.bodySmall?.color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ExpenseList(expenses: monthlyExpenses),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}

