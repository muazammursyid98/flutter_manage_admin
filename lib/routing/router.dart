import 'package:flutter/material.dart';

import '../pages/clients/clients.dart';
import '../pages/transaction/transaction.dart';
import '../pages/overview/overview.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(const OverviewPage());
    case transactionPageRoute:
      return _getPageRoute(const TransactionPage());
    case clientsPageRoute:
      return _getPageRoute(ClientsPage());
    default:
      return _getPageRoute(const OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
