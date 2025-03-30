import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../providers/expense_provider.dart';
import '../utils/app_theme.dart';

class CategoryForm extends StatefulWidget {
  final MyCategory? category;

  const CategoryForm({Key? key, this.category}) : super(key: key);

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  
  Color _selectedColor = AppTheme.categoryColors[0];
  IconData _selectedIcon = Icons.category;
  
  final List<IconData> _availableIcons = [
    Icons.category,
    Icons.restaurant,
    Icons.shopping_bag,
    Icons.directions_car,
    Icons.movie,
    Icons.receipt_long,
    Icons.favorite,
    Icons.flight,
    Icons.home,
    Icons.school,
    Icons.sports_basketball,
    Icons.fitness_center,
    Icons.pets,
    Icons.local_grocery_store,
    Icons.local_hospital,
    Icons.local_atm,
    Icons.more_horiz,
  ];

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _selectedColor = widget.category!.color;
      _selectedIcon = widget.category!.icon;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveCategory() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      
      final category = MyCategory(
        id: widget.category?.id,
        name: name,
        icon: _selectedIcon,
        color: _selectedColor,
      );
      
      final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);
      
      if (widget.category == null) {
        expenseProvider.addCategory(category);
      } else {
        expenseProvider.updateCategory(category);
      }
      
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.category == null ? 'Add Category' : 'Edit Category',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              
              // Name field
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  hintText: 'Enter category name',
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              // Color selector
              Text(
                'Color',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: AppTheme.categoryColors.length,
                  itemBuilder: (ctx, index) {
                    final color = AppTheme.categoryColors[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = color;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _selectedColor == color
                                ? Colors.white
                                : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            if (_selectedColor == color)
                              BoxShadow(
                                color: color.withValues(),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                          ],
                        ),
                        child: _selectedColor == color
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              
              // Icon selector
              Text(
                'Icon',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withValues(),
                  ),
                ),
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _availableIcons.length,
                  itemBuilder: (ctx, index) {
                    final icon = _availableIcons[index];
                    final isSelected = _selectedIcon == icon;
                    
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIcon = icon;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _selectedColor.withValues()
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? _selectedColor
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: isSelected ? _selectedColor : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              
              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveCategory,
                  child: Text(
                    widget.category == null ? 'Add Category' : 'Update Category',
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

