import 'package:hive/hive.dart';

part 'expense.g.dart';

const expenseBox = "expense";

const foodType = "food";
const groceryType = "grocery";
const carType = "car";
const shoppingType = "shopping";
const othersType = "others";
const entertainmentType = "entertainment";
const transportationType = "transportation";

const List<String> typeList = [
  foodType,
  groceryType,
  carType,
  shoppingType,
  entertainmentType,
  transportationType,
  othersType,
];

const List<String> othersCategories = [
  "Others",
];

const List<String> transportationCategories = [
  "Grab",
  "MyCar",
  "Others",
];

const List<String> entertainmentCategories = [
  "Watch Movie",
  "Others",
];

const List<String> shoppingCategories = [
  "Online",
  "Physical",
  "Others",
];

const List<String> foodCategories = [
  "breakfast",
  "lunch",
  "dinner",
  "tea time",
  "supper",
  "late night snack",
  "others",
];

const List<String> carCategories = [
  "maintenance",
  "parking",
  "fuel",
  "others",
];

const List<String> groceryCategories = [
  "-",
  "others",
];

List<String> getCategoriesBasedOnType(String type) {
  switch (type) {
    case foodType:
      return foodCategories;
    case groceryType:
      return groceryCategories;
    case carType:
      return carCategories;
    case shoppingType:
      return shoppingCategories;
    case entertainmentType:
      return entertainmentCategories;
    case transportationType:
      return transportationCategories;
    case othersType:
      return othersCategories;
  }

  return [];
}

@HiveType(typeId: 1)
class Expense {
  Expense({
    required this.uuid,
    required this.category,
    required this.type,
    required this.price,
    required this.description,
    required this.date,
  });

  @HiveField(0)
  String uuid;

  @HiveField(1)
  String category;

  @HiveField(2)
  String type;

  @HiveField(3)
  double price;

  @HiveField(4)
  String description;

  @HiveField(5)
  DateTime date;

  @override
  String toString() {
    return {
      uuid,
      category,
      type,
      price,
      description,
      date,
    }.toString();
  }
}
