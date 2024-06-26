import 'package:amazon_flutter/common/widgets/custom_button.dart';
import 'package:amazon_flutter/common/widgets/custom_text_field.dart';
import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:amazon_flutter/features/address/services/address_services.dart';
import 'package:amazon_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/address';
  const AddressScreen({super.key, required this.totalAmount});
  final String totalAmount;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final flatBuildingController = TextEditingController();
  final areaStreetController = TextEditingController();
  final pincodeController = TextEditingController();
  final townCityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  final addressServices = AdressServices();

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaStreetController.dispose();
    pincodeController.dispose();
    townCityController.dispose();
  }

  void onTapBuyButton() {
    addressToBeUsed = flatBuildingController.text +
        areaStreetController.text +
        pincodeController.text +
        townCityController.text;
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddresst(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalPrice: double.parse(widget.totalAmount));
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      hintText: 'Flat,house number, building',
                      controller: flatBuildingController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Area, Street',
                      controller: areaStreetController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Pincode',
                      controller: pincodeController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hintText: 'Town/City',
                      controller: townCityController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(text: 'Order', onTap: onTapBuyButton),
              )
            ],
          ),
        ),
      ),
    );
  }
}
