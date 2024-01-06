import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isPass;
  final TextEditingController controller;
  const CustomTextField(
      {super.key, required this.hintText, required this.controller,this.isPass = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black38),
          ),
          hintText: hintText),
      obscureText: isPass,
    );
  }
}
