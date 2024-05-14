import 'dart:io';

import 'package:amazon_flutter/constants/utils.dart';
import 'package:amazon_flutter/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary =
          CloudinaryPublic('dvbyv9sde', 'pri0yoee', cache: false);

      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        var res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          price: price,
          category: category,
          images: imageUrls);
          
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
