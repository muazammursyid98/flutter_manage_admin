const rootRoute = "/";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const transactionPageDisplayName = "Transaction";
const transactionPageRoute = "/transaction";

const clientsPageDisplayName = "Activity";
const clientsPageRoute = "/clients";

const specialPageDisplayName = "Special Booking";
const specialPageRoute = "/special";

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
  MenuItem(specialPageDisplayName, specialPageRoute),
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
