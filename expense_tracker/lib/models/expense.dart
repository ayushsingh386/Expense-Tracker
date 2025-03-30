import 'package:uuid/uuid.dart';
import 'category.dart';

const uuid = Uuid();

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final MyCategory category;
  final String? note;

  Expense({
    String? id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    this.note,
  }) : id = id ?? uuid.v4();

  Expense copyWith({
    String? title,
    double? amount,
    DateTime? date,
    MyCategory? category,
    String? note,
  }) {
    return Expense(
      id: id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'categoryId': category.id,
      'note': note,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json, List<MyCategory> categories) {
    final categoryId = json['categoryId'];
    final category = categories.firstWhere(
      (cat) => cat.id == categoryId,
      orElse: () => MyCategory.defaultCategories[0],
    );

    return Expense(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: category,
      note: json['note'],
    );
  }
}

