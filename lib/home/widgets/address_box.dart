import 'package:amazon_flutter/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 114, 226, 221),
          Color.fromARGB(255, 162, 236, 233),
        ], stops: [
          0.5,
          1.0
        ]),
      ),
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Deliver to ${user.name} - ${user.address}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          )),
          const Padding(
            padding: EdgeInsets.only(right: 5, top: 2),
            child: Icon(Icons.arrow_drop_down),
          ),
        ],
      ),
    );
  }
}
