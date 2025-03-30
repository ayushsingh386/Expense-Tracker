import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';
import 'add_expense_screen.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailScreen({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => AddExpenseScreen(expense: expense),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Expense'),
                  content: const Text('Are you sure you want to delete this expense?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Provider.of<ExpenseProvider>(context, listen: false)
                            .deleteExpense(expense.id);
                        if (context.mounted) {
                          Navigator.of(ctx).pop();
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and amount
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expense.title,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        NumberFormat.currency(symbol: 'INR').format(expense.amount),
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Details
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Category
                      ListTile(
                        leading: Icon(
                          expense.category.icon,
                          color: expense.category.color,
                          size: 28,
                        ),
                        title: const Text('Category'),
                        subtitle: Text(
                          expense.category.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      const Divider(),
                      
                      // Date
                      ListTile(
                        leading: Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).colorScheme.primary,
                          size: 28,
                        ),
                        title: const Text('Date'),
                        subtitle: Text(
                          DateFormat('MMMM dd, yyyy').format(expense.date),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                      
                      // Note (if available)
                      if (expense.note != null && expense.note!.isNotEmpty) ...[
                        const Divider(),
                        ListTile(
                          leading: Icon(
                            Icons.note,
                            color: Theme.of(context).colorScheme.primary,
                            size: 28,
                          ),
                          title: const Text('Note'),
                          subtitle: Text(expense.note!),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

