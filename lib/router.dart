import 'package:amazon_flutter/common/widgets/bottom_bar.dart';
import 'package:amazon_flutter/features/auth/screens/auth_screen.dart';
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
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(child: Text('Error, invalid Route provided')),
              ));
  }
}
