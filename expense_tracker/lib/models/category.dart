import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../utils/app_theme.dart';

const uuid = Uuid();

class MyCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  MyCategory({
    String? id,
    required this.name,
    required this.icon,
    required this.color,
  }) : id = id ?? uuid.v4();

  MyCategory copyWith({
    String? name,
    IconData? icon,
    Color? color,
  }) {
    return MyCategory(
      id: id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconCodePoint': icon.codePoint,
      'iconFontFamily': icon.fontFamily,
      'iconFontPackage': icon.fontPackage,
      'colorValue': color.blue,
    };
  }

  factory MyCategory.fromJson(Map<String, dynamic> json) {
    return MyCategory(
      id: json['id'],
      name: json['name'],
      icon: IconData(
        json['iconCodePoint'],
        fontFamily: json['iconFontFamily'],
        fontPackage: json['iconFontPackage'],
      ),
      color: Color(json['colorValue']),
    );
  }

  static List<MyCategory> defaultCategories = [
    MyCategory(
      name: 'Food & Dining',
      icon: Icons.restaurant,
      color: AppTheme.categoryColors[0],
    ),
    MyCategory(
      name: 'Transportation',
      icon: Icons.directions_car,
      color: AppTheme.categoryColors[1],
    ),
    MyCategory(
      name: 'Shopping',
      icon: Icons.shopping_bag,
      color: AppTheme.categoryColors[2],
    ),
    MyCategory(
      name: 'Entertainment',
      icon: Icons.movie,
      color: AppTheme.categoryColors[3],
    ),
    MyCategory(
      name: 'Bills & Utilities',
      icon: Icons.receipt_long,
      color: AppTheme.categoryColors[4],
    ),
    MyCategory(
      name: 'Health',
      icon: Icons.favorite,
      color: AppTheme.categoryColors[5],
    ),
    MyCategory(
      name: 'Travel',
      icon: Icons.flight,
      color: AppTheme.categoryColors[6],
    ),
    MyCategory(
      name: 'Other',
      icon: Icons.more_horiz,
      color: AppTheme.categoryColors[7],
    ),
  ];
}

