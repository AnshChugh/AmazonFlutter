import 'package:amazon_flutter/constants/global_variables.dart';

import '../../../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //sign up user
  void signUpUser(
      {required String email,
      required String password,
      required String name}) async {
    try {
      User user = User(
        id: '',
        name: name,
        address: '',
        password: password,
        email: email,
        token: '',
        type: '',
      );
      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-type': 'application/json; charset=UTF-8',
          });
      print(res);
    } catch (e) {
      print(e.toString());
    }
  }
}
