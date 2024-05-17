import 'dart:convert';
import 'dart:io';

import 'package:amazon_flutter/constants/error_handling.dart';
import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/constants/utils.dart';
import 'package:amazon_flutter/models/product.dart';
import 'package:amazon_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/products?category=$category'),
          headers: <String, String>{
            'Content-type': 'Application/json; charset=UTF-8',
            '-x-auth-token': userProvider.user.token
          });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var products = jsonDecode(res.body);
            for (int i = 0; i < products.length; i++) {
              productList.add(Product.fromjson(jsonEncode(products[i])));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return productList;
  }
}
