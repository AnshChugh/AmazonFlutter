import 'dart:convert';
import 'dart:io';

import 'package:amazon_flutter/constants/error_handling.dart';
import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/constants/utils.dart';
import 'package:amazon_flutter/models/user.dart';
import 'package:amazon_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AdressServices {
  void saveUserAddresst({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/api/save-user-address'),
              headers: <String, String>{
                'Content-type': 'Application/json; charset=UTF-8',
                '-x-auth-token': userProvider.user.token
              },
              body: jsonEncode({'address': address}));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(address: jsonDecode(res.body)['address']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder({
    required BuildContext context,
    required String address,
    required double totalPrice,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: <String, String>{
            'Content-type': 'Application/json; charset=UTF-8',
            '-x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalPrice
          }));

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(cart: List.empty());
            userProvider.setUserFromModel(user);
            Navigator.pop(context);
            showSnackBar(context, 'Your Order has been placed ');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
