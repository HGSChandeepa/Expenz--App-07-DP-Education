import 'dart:convert';

import 'package:expenz/models/expence_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenceService {
  final List<Expense> expensesList = [];

  Future<void> saveExpense(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList('expenses');

      // Convert the existing expenses to a list of Expense objects
      List<Expense> existingExpenseObjects = [];
      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJson(json.decode(e)))
            .toList();
      }

      // Add the new expense to the list
      existingExpenseObjects.add(expense);

      // Convert the list of Expense objects back to a list of strings
      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJson())).toList();

      // Save the updated list of expenses to shared preferences
      await prefs.setStringList('expenses', updatedExpenses);

      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expense added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Expense>> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingExpenses = prefs.getStringList('expenses');

    // Convert the existing expenses to a list of Expense objects
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => Expense.fromJson(json.decode(e)))
          .toList();
    }

    // Return the list of loaded expenses
    return loadedExpenses;
  }
}
