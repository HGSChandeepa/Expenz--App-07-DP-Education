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

  late List<Income> incomeList;
  late List<Expense> expenseList;

  @override
  final List<Widget> _pages = [
    const HomeScreen(),
    const TransactionsScreen(),
    const AddNewScreen(),
    const BudgetScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _pages,
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
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
            print(value);
          });
        },
      ),
    );
  }
}
