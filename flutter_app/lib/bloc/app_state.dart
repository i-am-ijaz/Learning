// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:flutter_app/models/login_handle.dart';

@immutable
class AppState {
  final bool isLoading;
  final LoginErrors? loginError;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchedNotes;

  const AppState({
    required this.isLoading,
    this.loginError,
    this.loginHandle,
    this.fetchedNotes,
  });

  const AppState.empty()
      : isLoading = false,
        loginError = null,
        loginHandle = null,
        fetchedNotes = null;

  @override
  String toString() {
    return 'AppState(isLoading: $isLoading, loginErrors: $loginError, loginHandle: $loginHandle, fetchedNotes: $fetchedNotes)';
  }
}
