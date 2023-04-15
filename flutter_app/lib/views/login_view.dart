// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_app/views/email_text_field.dart';
import 'package:flutter_app/views/password_text_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_app/views/login_btn.dart';

class LoginView extends HookWidget {
  const LoginView({
    super.key,
    required this.onLoginTapped,
  });
  final OnLoginTapped onLoginTapped;

  @override
  Widget build(BuildContext context) {
    final emailCont = useTextEditingController();
    final pwdCont = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          EmailTextField(
            controller: emailCont,
          ),
          PasswordTextField(
            passwordController: pwdCont,
          ),
          LoginBtn(
            emailController: emailCont,
            passwordController: pwdCont,
            onLoginTapped: onLoginTapped,
          ),
        ],
      ),
    );
  }
}
