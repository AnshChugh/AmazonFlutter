import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/features/account/screens/order_details_screen.dart';
import 'package:amazon_flutter/features/account/services/account_services.dart';
import 'package:amazon_flutter/features/account/widgets/single_product.dart';
import 'package:amazon_flutter/features/auth/widgets/loader.dart';
import 'package:amazon_flutter/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;

  final accountServices = AccountServices();

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Your Orders',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      'See all',
                      style: TextStyle(
                          color: GlobalVariables.selectedNavBarColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 170,
                  padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: (context, index) {
                      // temporary list
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, OrderDetailsScreen.routeName,
                              arguments: orders![index]);
                        },
                        child: SingleProduct(
                            img: orders![index].products[0].images[0]),
                      );
                    },
                  )),
            ],
          );
  }
}
