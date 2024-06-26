import 'package:amazon_flutter/common/widgets/custom_button.dart';
import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/features/admin/services/admin_services.dart';
import 'package:amazon_flutter/features/search/screens/search_screen.dart';
import 'package:amazon_flutter/models/order.dart';
import 'package:amazon_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details ';
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int currentStep = 0;
  final adminServices = AdminServices();
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  // ONLY FOR ADMIN!!!
  void changeOrderStatus(int status) {
    adminServices.changeOrder(
        context: context,
        order: widget.order,
        onSuccess: () {
          setState(() {
            currentStep += 1;
          });
        },
        status: status + 1);
  }

  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false).user;
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
                          onFieldSubmitted: navigateToSearchScreen,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View Order Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Order Date:    ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}'),
                    Text('Order id:   ${widget.order.id}'),
                    Text('Order Total :   \$${widget.order.totalPrice}')
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Purchase Details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Text(
                                widget.order.products[i].name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'Quantity: ${widget.order.quantity[i].toString()}'),
                            ],
                          ))
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Tracking',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  child: Stepper(
                      controlsBuilder: (context, details) {
                        if (user.type == 'admin') {
                          return CustomButton(
                              text: 'Done',
                              onTap: () =>
                                  changeOrderStatus(details.currentStep));
                        } else {
                          return const SizedBox();
                        }
                      },
                      currentStep: currentStep,
                      steps: [
                        Step(
                            title: const Text('Pending'),
                            content:
                                const Text('Your Order is yet to be delivered'),
                            isActive: currentStep > 0,
                            state: currentStep > 0
                                ? StepState.complete
                                : StepState.indexed),
                        Step(
                            title: const Text('Completed'),
                            content:
                                const Text('Your Order has been delivered '),
                            isActive: currentStep > 1,
                            state: currentStep > 1
                                ? StepState.complete
                                : StepState.indexed),
                        Step(
                            title: const Text('Recieved'),
                            content: const Text(
                                'Your Order has been deliver and signed'),
                            isActive: currentStep > 2,
                            state: currentStep > 2
                                ? StepState.complete
                                : StepState.indexed),
                        Step(
                            title: const Text('Delivered'),
                            content: const Text(
                                'Your Order has been delivered and signed'),
                            isActive: currentStep >= 3,
                            state: currentStep >= 3
                                ? StepState.complete
                                : StepState.indexed),
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
