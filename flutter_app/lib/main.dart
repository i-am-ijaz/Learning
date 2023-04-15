import 'package:flutter/material.dart';

import 'package:flutter_app/apis/login_api.dart';
import 'package:flutter_app/apis/notes_api.dart';
import 'package:flutter_app/bloc/actions.dart';
import 'package:flutter_app/bloc/app_bloc.dart';
import 'package:flutter_app/bloc/app_state.dart';
import 'package:flutter_app/models/login_handle.dart';
import 'package:flutter_app/shared/constants/strings.dart';
import 'package:flutter_app/shared/dialogs/generic_dialog.dart';
import 'package:flutter_app/shared/loading/loading_screen.dart';
import 'package:flutter_app/views/iterable_list_view.dart';
import 'package:flutter_app/views/login_view.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BLOC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => AppBloc(
          loginApi: LoginApi(),
          notesApi: NotesApi(),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(homePage),
          ),
          body: BlocConsumer<AppBloc, AppState>(
            listener: (context, appState) {
              if (appState.isLoading) {
                LoadingScreen.instance().show(
                  context: context,
                  text: pleaseWait,
                );
              } else {
                LoadingScreen.instance().hide();
              }

              final loginError = appState.loginError;
              if (loginError != null) {
                showGenericDialog(
                  context: context,
                  title: loginErrorDialogTitle,
                  content: loginErrorDialogContent,
                  optionsBuilder: () => {
                    ok: true,
                  },
                );
              }

              if (!appState.isLoading &&
                  appState.loginError == null &&
                  appState.loginHandle == const LoginHandle.fooBar() &&
                  appState.fetchedNotes == null) {
                context.read<AppBloc>().add(
                      const LoadNotesAction(),
                    );
              }
            },
            builder: (context, appState) {
              final notes = appState.fetchedNotes;
              if (notes == null) {
                return LoginView(
                  onLoginTapped: (email, password) {
                    context.read<AppBloc>().add(
                          LoginAction(
                            email: email,
                            password: password,
                          ),
                        );
                  },
                );
              } else {
                return notes.toListView();
              }
            },
          ),
        ),
      ),
    );
  }
}
