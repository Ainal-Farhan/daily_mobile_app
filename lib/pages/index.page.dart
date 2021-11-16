import 'package:daily/pages/add_expense/add_expense.page.dart';
import 'package:daily/pages/home/home.page.dart';
import 'package:daily/pages/main.page.dart';
import 'package:flutter/material.dart';

const String mainPage = "MainPage";
const String homePage = "HomePage";
const String addExpensePage = "addExpensePage";

Widget getPage({
  String pageName = '',
  Map<String, dynamic> pageVariables = const {},
}) {
  switch (pageName) {
    case mainPage:
      return const MainPage();
    default:
      return Container();
  }
}

Route<dynamic> getPageRoute({
  String pageName = '',
  Map<String, dynamic> pageVariables = const {},
}) {
  switch (pageName) {
    case homePage:
      return HomePage.route(title: pageVariables["title"]);
    case addExpensePage:
      return AddExpensePage.route();
  }

  return HomePage.route(title: pageVariables["title"]);
}
