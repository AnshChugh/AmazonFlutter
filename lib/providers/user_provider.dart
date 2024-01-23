import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: "",
      email: "",
      address: "",
      name: "",
      password: "",
      token: "",
      type: "");

  User get user => _user;

  void setUser(String user) {
    _user = User.fromjson(user);
    notifyListeners();
  }
}
