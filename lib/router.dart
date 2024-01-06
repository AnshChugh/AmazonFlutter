import 'package:amazon_flutter/features/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRouter(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => AuthScreen(),
      );
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: Center(child: Text('Error, invalid Route provided')),
              ));
  }
}
