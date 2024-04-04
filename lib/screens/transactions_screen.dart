import 'package:expenz/models/expence_model.dart';
import 'package:expenz/services/expence_services.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  // Define expensesList at the class level
  List<Expense> expensesList = [];

  @override
  void initState() {
    super.initState();
    // Fetch all the expenses

    setState(() {
      fetchExpenses();
    });
  }

  // Function to fetch expenses
  void fetchExpenses() async {
    // Load expenses from shared preferences
    List<Expense> loadedExpenses = await ExpenceService().loadExpenses();

    setState(() {
      // Update expensesList with the fetched expenses
      expensesList = loadedExpenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Show all the expenses and income
              ListView.builder(
                shrinkWrap: true,
                itemCount: expensesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(expensesList[index].title),
                    subtitle: Text(expensesList[index].description),
                    trailing: Text(expensesList[index].amount.toString()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
