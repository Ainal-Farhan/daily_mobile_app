import 'package:flutter/material.dart';
import 'package:daily/pages/index.page.dart' as page_index;

const String homePageRoute = "homePage";
const String addExpensePageRoute = "addExpensePage";

Route<dynamic> createRoute(settings) {
  switch (settings.name) {
    case homePageRoute:
      return page_index.getPageRoute(
        pageName: page_index.mainPage,
        pageVariables: {"title": "Page Report"},
      );
    case addExpensePageRoute:
      return page_index.getPageRoute(
        pageName: page_index.addExpensePage,
        pageVariables: {},
      );
  }

  return page_index.getPageRoute(
    pageName: page_index.mainPage,
    pageVariables: {"title": "Page Report"},
  );
}
