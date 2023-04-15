// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/constants/strings.dart';
import 'package:flutter_app/shared/dialogs/generic_dialog.dart';

typedef OnLoginTapped = void Function(
  String email,
  String password,
);

class LoginBtn extends StatelessWidget {
  const LoginBtn({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.onLoginTapped,
  }) : super(key: key);
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final OnLoginTapped onLoginTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
      ),
      child: TextButton(
        onPressed: () {
          final email = emailController.text.trim();
          final password = passwordController.text;

          if (email.isEmpty || password.isEmpty) {
            showGenericDialog<bool>(
              context: context,
              title: emailOrPasswordEmptyDialogTitle,
              content: emailOrPasswordEmptyDescription,
              optionsBuilder: () => {
                ok: true,
              },
            );
          } else {
            onLoginTapped(
              email,
              password,
            );
          }
        },
        child: const Text(login),
      ),
    );
  }
}
