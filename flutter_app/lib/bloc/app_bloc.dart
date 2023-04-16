// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:flutter_app/apis/login_api.dart';
import 'package:flutter_app/apis/notes_api.dart';
import 'package:flutter_app/models/login_handle.dart';

import 'actions.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;
  final LoginHandle acceptedLoginHandle;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
    required this.acceptedLoginHandle,
  }) : super(const AppState.empty()) {
    on<LoginAction>(
      (event, emit) async {
        emit(
          const AppState(
            isLoading: true,
            loginError: null,
            loginHandle: null,
            fetchedNotes: null,
          ),
        );

        final loginHandle = await loginApi.login(
          email: event.email,
          password: event.password,
        );

        emit(
          AppState(
            isLoading: false,
            loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
            loginHandle: loginHandle,
            fetchedNotes: null,
          ),
        );
      },
    );

    on<LoadNotesAction>(
      (event, emit) async {
        emit(
          AppState(
            isLoading: true,
            loginError: null,
            loginHandle: state.loginHandle,
            fetchedNotes: null,
          ),
        );

        final loginHandle = state.loginHandle;

        if (loginHandle != acceptedLoginHandle) {
          emit(
            AppState(
              isLoading: false,
              loginError: LoginErrors.invalidHandle,
              loginHandle: loginHandle,
              fetchedNotes: null,
            ),
          );
          return;
        }

        final notes = await notesApi.getNotes(
          loginHandle: loginHandle!,
        );

        emit(
          AppState(
            isLoading: false,
            loginError: null,
            loginHandle: loginHandle,
            fetchedNotes: notes,
          ),
        );
      },
    );
  }
}
