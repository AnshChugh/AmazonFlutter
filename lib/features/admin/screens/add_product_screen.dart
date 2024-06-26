import 'dart:io';

import 'package:amazon_flutter/common/widgets/custom_button.dart';
import 'package:amazon_flutter/common/widgets/custom_text_field.dart';
import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/constants/utils.dart';
import 'package:amazon_flutter/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final AdminServices adminServices = AdminServices();
  String category = 'Mobiles';
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProduct(
          context: context,
          name: productNameController.text,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          category: category,
          images: images);
    }
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Container(
            alignment: Alignment.center,
            child: Text(
              "Add Product",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index, realIndex) {
                          return Image.file(
                            images[index],
                            fit: BoxFit.cover,
                            height: 200,
                          );
                        },
                        options:
                            CarouselOptions(viewportFraction: 1, height: 200),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            dashPattern: [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.folder_open_outlined),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Select Product Images',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400),
                                  )
                                ],
                              ),
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    hintText: 'Product Name',
                    controller: productNameController),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Description',
                  controller: descriptionController,
                  maxLines: 7,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Price',
                  controller: priceController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Quantity',
                  controller: quantityController,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(text: "sell", onTap: sellProduct)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
