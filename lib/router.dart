import 'package:amazon_flutter/common/widgets/bottom_bar.dart';
import 'package:amazon_flutter/features/admin/screens/add_product_screen.dart';
import 'package:amazon_flutter/features/auth/screens/auth_screen.dart';
import 'package:amazon_flutter/home/screens/category_deals_screen.dart';
import 'package:amazon_flutter/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRouter(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (_) => BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => AddProductScreen());
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (cat) => CategoryDealsScreen(category: category));
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(child: Text('Error, invalid Route provided')),
              ));
  }
}
