import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense.dart';
import '../models/category.dart';

class ExpenseService {
  static const String _expensesKey = 'expenses';
  static const String _categoriesKey = 'categories';

  // Save expenses to local storage
  Future<void> saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    final expensesJson = expenses.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_expensesKey, expensesJson);
  }

  // Load expenses from local storage
  Future<List<Expense>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final categories = await loadCategories();
    
    final expensesJson = prefs.getStringList(_expensesKey) ?? [];
    return expensesJson
        .map((e) => Expense.fromJson(jsonDecode(e), categories))
        .toList();
  }

  // Save categories to local storage
  Future<void> saveCategories(List<MyCategory> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesJson = categories.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(_categoriesKey, categoriesJson);
  }

  // Load categories from local storage
  Future<List<MyCategory>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesJson = prefs.getStringList(_categoriesKey);
    
    if (categoriesJson == null || categoriesJson.isEmpty) {
      await saveCategories(MyCategory.defaultCategories);
      return MyCategory.defaultCategories;
    }
    
    return categoriesJson
        .map((c) => MyCategory.fromJson(jsonDecode(c)))
        .toList();
  }

  // Add a new expense
  Future<void> addExpense(Expense expense) async {
    final expenses = await loadExpenses();
    expenses.add(expense);
    await saveExpenses(expenses);
  }

  // Update an existing expense
  Future<void> updateExpense(Expense updatedExpense) async {
    final expenses = await loadExpenses();
    final index = expenses.indexWhere((e) => e.id == updatedExpense.id);
    
    if (index != -1) {
      expenses[index] = updatedExpense;
      await saveExpenses(expenses);
    }
  }

  // Delete an expense
  Future<void> deleteExpense(String id) async {
    final expenses = await loadExpenses();
    expenses.removeWhere((e) => e.id == id);
    await saveExpenses(expenses);
  }

  // Add a new category
  Future<void> addCategory(MyCategory category) async {
    final categories = await loadCategories();
    categories.add(category);
    await saveCategories(categories);
  }

  // Update an existing category
  Future<void> updateCategory(MyCategory updatedCategory) async {
    final categories = await loadCategories();
    final index = categories.indexWhere((c) => c.id == updatedCategory.id);
    
    if (index != -1) {
      categories[index] = updatedCategory;
      await saveCategories(categories);
    }
  }

  // Delete a category
  Future<void> deleteCategory(String id) async {
    final categories = await loadCategories();
    categories.removeWhere((c) => c.id == id);
    await saveCategories(categories);
  }
}

