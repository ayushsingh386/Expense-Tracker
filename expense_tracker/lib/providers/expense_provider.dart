import 'package:flutter/foundation.dart';
import '../models/expense.dart';
import '../models/category.dart';
import '../services/expense_service.dart';

class ExpenseProvider with ChangeNotifier {
  final ExpenseService _expenseService = ExpenseService();
  
  List<Expense> _expenses = [];
  List<MyCategory> _categories = [];
  bool _isLoading = false;

  List<Expense> get expenses => [..._expenses];
  List<MyCategory> get categories => [..._categories];
  bool get isLoading => _isLoading;

  // Initialize the provider by loading data
  Future<void> initialize() async {
    _setLoading(true);
    await _loadCategories();
    await _loadExpenses();
    _setLoading(false);
  }

  // Load expenses from storage
  Future<void> _loadExpenses() async {
    _expenses = await _expenseService.loadExpenses();
    // Sort expenses by date (newest first)
    _expenses.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  // Load categories from storage
  Future<void> _loadCategories() async {
    _categories = await _expenseService.loadCategories();
    notifyListeners();
  }

  // Add a new expense
  Future<void> addExpense(Expense expense) async {
    await _expenseService.addExpense(expense);
    await _loadExpenses();
  }

  // Update an existing expense
  Future<void> updateExpense(Expense expense) async {
    await _expenseService.updateExpense(expense);
    await _loadExpenses();
  }

  // Delete an expense
  Future<void> deleteExpense(String id) async {
    await _expenseService.deleteExpense(id);
    await _loadExpenses();
  }

  // Add a new category
  Future<void> addCategory(MyCategory category) async {
    await _expenseService.addCategory(category);
    await _loadCategories();
  }

  // Update an existing category
  Future<void> updateCategory(MyCategory category) async {
    await _expenseService.updateCategory(category);
    await _loadCategories();
  }

  // Delete a category
  Future<void> deleteCategory(String id) async {
    await _expenseService.deleteCategory(id);
    await _loadCategories();
  }

  // Get expenses for a specific month and year
  List<Expense> getExpensesForMonth(int month, int year) {
    return _expenses.where((expense) {
      return expense.date.month == month && expense.date.year == year;
    }).toList();
  }

  // Get total expenses for a specific month and year
  double getTotalForMonth(int month, int year) {
    final monthlyExpenses = getExpensesForMonth(month, year);
    return monthlyExpenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  // Get expenses by category for a specific month and year
  Map<MyCategory, double> getExpensesByCategory(int month, int year) {
    final monthlyExpenses = getExpensesForMonth(month, year);
    final map = <MyCategory, double>{};
    
    for (final expense in monthlyExpenses) {
      if (map.containsKey(expense.category)) {
        map[expense.category] = map[expense.category]! + expense.amount;
      } else {
        map[expense.category] = expense.amount;
      }
    }
    
    return map;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

