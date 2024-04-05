import 'package:expenz/models/expence_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new.dart';
import 'package:expenz/screens/budget_screen.dart';
import 'package:expenz/screens/home_screen.dart';
import 'package:expenz/screens/profile_screen.dart';
import 'package:expenz/screens/transactions_screen.dart';
import 'package:expenz/services/expence_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: kMainColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.monetization_on),
        title: "Transactions",
        activeColorPrimary: kMainColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.add,
          color: kWhite,
        ),
        title: "Add New",
        activeColorPrimary: kMainColor,
        inactiveColorPrimary: kWhite,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.rocket),
        title: "Budget",
        activeColorPrimary: kMainColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile",
        activeColorPrimary: kMainColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  // Define the list of incomes
  List<Expense> expensesList = [];
  List<Income> incomesList = [];

  @override
  void initState() {
    super.initState();
    // Fetch all the expenses when the widget is first initialized
    fetchExpenses();
  }

  // Function to fetch expenses
  void fetchExpenses() async {
    // Load expenses from shared preferences
    List<Expense> loadedExpenses = await ExpenceService().loadExpenses();

    // Update expensesList with the fetched expenses
    setState(() {
      expensesList = loadedExpenses;
    });
  }

  // Function to add a new expense
  void addNewExpense(Expense newExpense) {
    // Save the new expense to shared preferences
    ExpenceService().saveExpense(newExpense, context);

    // Update the list of expenses
    setState(() {
      expensesList.add(newExpense);
    });
  }

  // Function to delete an expense
  void deleteExpense(Expense expense) {
    // Delete the expense from shared preferences
    ExpenceService().deleteExpense(expense.id, context);

    // Update the list of expenses
    setState(() {
      expensesList.remove(expense);
    });
  }

  //Function to add new income
  void addNewIncome(Income newIncome) {
    // Save the new income to shared preferences
    IncomeServices().saveIncome(newIncome, context);

    // Update the list of incomes
    setState(() {
      incomesList.add(newIncome);
    });
  }

  // Function to delete an income
  void deleteIncome(Income income) {
    // Delete the income from shared preferences
    IncomeServices().deleteIncome(income.id, context);

    // Update the list of incomes
    setState(() {
      incomesList.remove(income);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const BudgetScreen(),
      const HomeScreen(),
      TransactionsScreen(
        expensesList: expensesList,
        onDismissedExpenses: deleteExpense,
        incomeList: incomesList,
        onDismissedIncome: deleteIncome,
      ),
      AddNewScreen(
        addExpense: addNewExpense,
        addIcome: addNewIncome,
      ),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: pages,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style17,
        onItemSelected: (value) {
          setState(() {
            // print(value);
          });
        },
      ),
    );
  }
}
