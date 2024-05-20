import 'package:amazon_flutter/common/widgets/bottom_bar.dart';
import 'package:amazon_flutter/features/account/screens/order_details_screen.dart';
import 'package:amazon_flutter/features/address/screens/address_screen.dart';
import 'package:amazon_flutter/features/admin/screens/add_product_screen.dart';
import 'package:amazon_flutter/features/auth/screens/auth_screen.dart';
import 'package:amazon_flutter/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_flutter/features/search/screens/search_screen.dart';
import 'package:amazon_flutter/home/screens/category_deals_screen.dart';
import 'package:amazon_flutter/home/screens/home_screen.dart';
import 'package:amazon_flutter/models/order.dart';
import 'package:amazon_flutter/models/product.dart';
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
          builder: (_) => CategoryDealsScreen(category: category));

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));

    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (_) => ProductDetailsScreen(product: product),
      );

    case AddressScreen.routeName:
      var amount = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => AddressScreen(totalAmount: amount),
      );
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        builder: (_) => OrderDetailsScreen(order: order),
      );

    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(child: Text('Error, invalid Route provided')),
              ));
  }
}
