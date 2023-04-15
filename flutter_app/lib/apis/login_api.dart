import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_app/models/login_handle.dart';

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi extends LoginApiProtocol {
  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 2),
        () => email == 'foo@bar.com' && password == 'foobar',
      ).then(
        (isLoggedIn) => isLoggedIn ? const LoginHandle.fooBar() : null,
      );
}
