// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/apis/login_api.dart';
import 'package:flutter_app/apis/notes_api.dart';
import 'package:flutter_app/bloc/actions.dart';
import 'package:flutter_app/bloc/app_bloc.dart';
import 'package:flutter_app/bloc/app_state.dart';
import 'package:flutter_app/models/login_handle.dart';

const Iterable<Note> mockNotes = [
  Note(title: 'Note 1'),
  Note(title: 'Note 2'),
  Note(title: 'Note 3'),
];

@immutable
class DummyNotesApi implements NotesApiProtocol {
  final LoginHandle acceptedLoginHandle;
  final Iterable<Note>? notesToRetrunForAcceptedLoginHandle;

  const DummyNotesApi({
    required this.acceptedLoginHandle,
    required this.notesToRetrunForAcceptedLoginHandle,
  });

  const DummyNotesApi.empty()
      : acceptedLoginHandle = const LoginHandle.fooBar(),
        notesToRetrunForAcceptedLoginHandle = null;

  @override
  Future<Iterable<Note>?> getNotes({
    required LoginHandle loginHandle,
  }) async {
    if (loginHandle == acceptedLoginHandle) {
      return notesToRetrunForAcceptedLoginHandle;
    } else {
      return null;
    }
  }
}

@immutable
class DummyLoginApi implements LoginApi {
  final String acceptedEmail;
  final String acceptedPassword;
  final LoginHandle handleToReturn;
  const DummyLoginApi({
    required this.acceptedEmail,
    required this.acceptedPassword,
    required this.handleToReturn,
  });

  const DummyLoginApi.empty()
      : acceptedEmail = '',
        acceptedPassword = '',
        handleToReturn = const LoginHandle.fooBar();

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) async {
    if (email == acceptedEmail && password == acceptedPassword) {
      return handleToReturn;
    } else {
      return null;
    }
  }
}

void main() {
  const acceptedLoginHandle = LoginHandle(token: 'ABC');

  blocTest(
    'Initial state of the block should be AppState.empty()',
    build: () => AppBloc(
      loginApi: const DummyLoginApi.empty(),
      notesApi: const DummyNotesApi.empty(),
      acceptedLoginHandle: acceptedLoginHandle,
    ),
    verify: (appState) => expect(
      appState.state,
      const AppState.empty(),
    ),
  );

  blocTest(
    'Can we login with correct creds',
    build: () {
      return AppBloc(
        acceptedLoginHandle: acceptedLoginHandle,
        loginApi: const DummyLoginApi(
          acceptedEmail: 'xyb@gmail.com',
          acceptedPassword: 'food',
          handleToReturn: acceptedLoginHandle,
        ),
        notesApi: const DummyNotesApi.empty(),
      );
    },
    act: (appBloc) => appBloc.add(
      const LoginAction(
        email: 'xyb@gmail.com',
        password: 'food',
      ),
    ),
    expect: () => [
      const AppState(
        isLoading: true,
        loginError: null,
        loginHandle: null,
        fetchedNotes: null,
      ),
      const AppState(
        isLoading: false,
        loginError: null,
        loginHandle: acceptedLoginHandle,
        fetchedNotes: null,
      ),
    ],
  );

  blocTest(
    'Login with invalid credentials',
    build: () => AppBloc(
      acceptedLoginHandle: acceptedLoginHandle,
      loginApi: const DummyLoginApi(
        acceptedEmail: 'foo@bar.com',
        acceptedPassword: 'foobar',
        handleToReturn: acceptedLoginHandle,
      ),
      notesApi: const DummyNotesApi.empty(),
    ),
    act: (appBloc) => appBloc.add(
      const LoginAction(
        email: 'foo@bar.com',
        password: 'foobar',
      ),
    ),
    expect: () => [
      const AppState(
        isLoading: true,
        loginError: null,
        loginHandle: null,
        fetchedNotes: null,
      ),
      const AppState(
        isLoading: false,
        loginError: null,
        loginHandle: acceptedLoginHandle,
        fetchedNotes: null,
      ),
    ],
  );

  blocTest(
    'Load notes with some valid login handle',
    build: () => AppBloc(
      acceptedLoginHandle: acceptedLoginHandle,
      loginApi: const DummyLoginApi(
        acceptedEmail: 'foo@bar.com',
        acceptedPassword: 'foobar',
        handleToReturn: acceptedLoginHandle,
      ),
      notesApi: const DummyNotesApi(
        acceptedLoginHandle: acceptedLoginHandle,
        notesToRetrunForAcceptedLoginHandle: mockNotes,
      ),
    ),
    act: (appBloc) {
      appBloc.add(
        const LoginAction(
          email: 'foo@bar.com',
          password: 'foobar',
        ),
      );
      appBloc.add(
        const LoadNotesAction(),
      );
    },
    expect: () => [
      const AppState(
        isLoading: true,
        loginError: null,
        loginHandle: null,
        fetchedNotes: null,
      ),
      const AppState(
        isLoading: false,
        loginError: null,
        loginHandle: acceptedLoginHandle,
        fetchedNotes: null,
      ),
      const AppState(
        isLoading: true,
        loginError: null,
        loginHandle: acceptedLoginHandle,
        fetchedNotes: null,
      ),
      const AppState(
        isLoading: false,
        loginError: null,
        loginHandle: acceptedLoginHandle,
        fetchedNotes: mockNotes,
      ),
    ],
  );
}
