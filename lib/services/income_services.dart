import 'package:expenz/models/income_model.dart';

class IncomeService {
  final List<Income> incomeList = [];

  //Methode to add new income
  void addIncome(Income income) {
    incomeList.add(income);
  }
}
