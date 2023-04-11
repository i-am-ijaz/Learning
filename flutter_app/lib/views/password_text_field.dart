import 'package:flutter/material.dart';
import 'package:flutter_app/shared/constants/strings.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: enterYourEmailHere,
      ),
    );
  }
}
