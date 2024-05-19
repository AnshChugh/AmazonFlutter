import 'package:amazon_flutter/common/widgets/custom_button.dart';
import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/features/cart/widgets/cart_product.dart';
import 'package:amazon_flutter/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_flutter/features/search/screens/search_screen.dart';
import 'package:amazon_flutter/home/widgets/address_box.dart';
import 'package:amazon_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: GlobalVariables.appBarGradient),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      margin: const EdgeInsets.only(left: 15),
                      child: Material(
                        borderRadius: BorderRadius.circular(7),
                        elevation: 1,
                        child: TextFormField(
                          onFieldSubmitted: (navigateToSearchScreen),
                          decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  left: 6,
                                ),
                                child: Icon(
                                  Icons.search,
                                  size: 23,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(top: 18),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide(
                                    color: Colors.black38, width: 1)),
                            hintText: 'Search Amazon.in',
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      color: Colors.transparent,
                      height: 42,
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      child: const Icon(
                        Icons.mic,
                        color: Colors.black,
                        size: 25,
                      )),
                ],
              ))),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'Proceed to buy (${user.cart.length} items)',
                onTap: () {},
                color: Colors.yellow.shade600,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
