import 'package:flutter/material.dart';
import 'package:flutter_app/shared/constants/strings.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: enterYourPasswordHere,
      ),
    );
  }
}
