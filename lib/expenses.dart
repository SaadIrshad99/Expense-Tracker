import 'package:expenses_tracker/expenses_list.dart';
import 'package:expenses_tracker/models/expense.dart';
import 'package:expenses_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void _addExpense() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpenseToList));
  }

  void _addExpenseToList(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpenseFromList(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense Deleted'),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  final List<Expense> _registeredExpenses = [
    Expense(
      category: Category.food,
      title: 'Vegetables',
      amount: 100.00,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.housing,
      title: 'House Rent',
      amount: 2000.00,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.clothing,
      title: 'Pants',
      amount: 1000.00,
      date: DateTime.now(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Widget content =
        const Center(child: Text('No Expense Added Yet!! , Add Some '));

    if (_registeredExpenses.isEmpty == false) {
      content = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpenseFromList,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddExpense'),
        actions: [
          IconButton(
            onPressed: _addExpense,
            icon: const Icon(
              Icons.add,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: content,
          ),
        ],
      ),
    );
  }
}
