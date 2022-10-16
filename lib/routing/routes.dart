const rootRoute = "/";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const transactionPageDisplayName = "Transaction";
const transactionPageRoute = "/transaction";

const clientsPageDisplayName = "Activity";
const clientsPageRoute = "/clients";

const salesPageDisplayName = "Sales";
const salesPageRoute = "/sales";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItems = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(transactionPageDisplayName, transactionPageRoute),
  MenuItem(clientsPageDisplayName, clientsPageRoute),
  MenuItem(salesPageDisplayName, salesPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
//TODO: delete
/* List sideMenuItems = [
  overviewPageRoute,
  driversPageRoute,
  clientsPageRoute,
  authenticationPageRoute
]; */
