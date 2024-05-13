import 'package:amazon_flutter/common/widgets/bottom_bar.dart';
import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/features/admin/screens/admin_screen.dart';
import 'package:amazon_flutter/features/auth/screens/auth_screen.dart';
import 'package:amazon_flutter/features/auth/services/auth_service.dart';
import 'package:amazon_flutter/providers/user_provider.dart';
import 'package:amazon_flutter/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context: context);
  }

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
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'? const BottomBar()
          : const AdminScreen()
          : const AuthScreen(),
      onGenerateRoute: (settings) => generateRouter(settings),
      debugShowCheckedModeBanner: false,
    );
  }
}
