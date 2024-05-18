import 'dart:convert';

import 'package:amazon_flutter/constants/error_handling.dart';
import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/constants/utils.dart';
import 'package:amazon_flutter/models/product.dart';
import 'package:amazon_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,required Product product, required double rating
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/rate-product'),
          headers: <String, String>{
            'Content-type': 'Application/json; charset=UTF-8',
            '-x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'id':product.id,
            'rating':rating
          }));
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
