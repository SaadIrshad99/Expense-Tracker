import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {
  housing,
  transport,
  food,
  health,
  education,
  entertainment,
  clothing,
  debts,
}

const categoryIcons = {
  Category.housing: Icons.home_filled,
  Category.transport: Icons.flight_takeoff,
  Category.food: Icons.food_bank,
  Category.health: Icons.health_and_safety,
  Category.education: Icons.school,
  Category.entertainment: Icons.movie,
  Category.clothing: Icons.shopping_bag,
  Category.debts: Icons.money
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
      {required this.category,
      required this.title,
      required this.amount,
      required this.date})
      : id = uuid.v4();

  String get formattedDate {
    return dateFormatter.format(date);
  }
}
