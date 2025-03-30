import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Extension to add a custom withValues method to Color
extension ColorExtension on Color {
  Color withValues({double? alpha, double? red, double? green, double? blue}) {
    return Color.fromARGB(
      (alpha ?? this.alpha).toInt(),
      (red ?? this.red).toInt(),
      (green ?? this.green).toInt(),
      (blue ?? this.blue).toInt(),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final double totalAmount;

  const SummaryCard({Key? key, required this.totalAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Expenses',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 128),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              NumberFormat.currency(symbol: 'INR ').format(totalAmount),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 128), // Example usage
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}