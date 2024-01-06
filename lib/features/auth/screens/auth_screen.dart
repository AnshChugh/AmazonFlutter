import 'package:amazon_flutter/common/widgets/custom_button.dart';
import 'package:amazon_flutter/common/widgets/custom_text_field.dart';
import 'package:amazon_flutter/constants/global_variables.dart';
import 'package:flutter/material.dart';

enum Auth { signup, signin }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = '/auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: GlobalVariables.greyBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                ListTile(
                  title: const Text(
                    'Create Account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  tileColor: _auth == Auth.signup
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signup,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signup)
                  Container(
                    decoration: const BoxDecoration(
                        color: GlobalVariables.backgroundColor),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          hintText: 'Name',
                          controller: _nameController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: 'Email',
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            hintText: 'Password',
                            controller: _passController,
                            isPass: true),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: 'submit',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ListTile(
                  title: const Text(
                    'Sign In',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  tileColor: _auth == Auth.signin
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundColor,
                  leading: Radio(
                    activeColor: GlobalVariables.secondaryColor,
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signin)
                  Container(
                    decoration: const BoxDecoration(
                        color: GlobalVariables.backgroundColor),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          hintText: 'Email',
                          controller: _emailController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                            hintText: 'Password',
                            controller: _passController,
                            isPass: true),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomButton(
                          text: 'Sign In',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
