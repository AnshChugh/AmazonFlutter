import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/features/auth/screens/auth_screen.dart';
import 'package:amazon_flutter/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          )),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Hello title'),
        ),
        body: Column(
          children: [
            const Center(child: Text('Hello')),
            Builder(
              builder: (context) {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context,AuthScreen.routeName );
                    },
                    child: const Text('click'));
                    
              }
            ),
          ],
        ),
      ),
      onGenerateRoute: (settings) => generateRouter(settings),
      debugShowCheckedModeBanner: false,
    );
  }
}
