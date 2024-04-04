//category enum

enum IncomeCategory {
  freelance,
  salary,
  passive,
  sales,
}

//category images
final Map<IncomeCategory, String> expenseCategoryImages = {
  IncomeCategory.freelance: "assets/images/restaurant.png",
  IncomeCategory.passive: "assets/images/car.png",
  IncomeCategory.sales: "assets/images/health.png",
  IncomeCategory.salary: "assets/images/bag.png",
};

final class Income {
  final int id;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final DateTime time;
  final String description;

  Income({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });
}
