import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../models/category.dart';

class ExpenseChart extends StatelessWidget {
  final Map<MyCategory, double> expensesByCategory;

  const ExpenseChart({Key? key, required this.expensesByCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalAmount = expensesByCategory.values.fold(0.0, (sum, amount) => sum + amount);
    
    return Row(
      children: [
        // Pie chart
        Expanded(
          flex: 3,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: expensesByCategory.entries.map((entry) {
                final category = entry.key;
                final amount = entry.value;
                final percentage = (amount / totalAmount) * 100;
                
                return PieChartSectionData(
                  color: category.color,
                  value: amount,
                  title: '${percentage.toStringAsFixed(1)}%',
                  radius: 100,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        
        // Legend
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: expensesByCategory.entries.map((entry) {
              final category = entry.key;
              final amount = entry.value;
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: category.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        category.name,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(symbol: 'INR ').format(amount),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

