import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

import 'package:flutter_app/extensions/extensions.dart';

const names = ['Foo', 'Bar', 'Baz'];

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() => emit(names.getRandomElement());
}

class CubitHomePage extends StatefulWidget {
  const CubitHomePage({super.key});

  @override
  State<CubitHomePage> createState() => _CubitHomePageState();
}

class _CubitHomePageState extends State<CubitHomePage> {
  late final NamesCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = NamesCubit();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<String?>(
        stream: _cubit.stream,
        builder: (ctx, snapshot) {
          final button = TextButton(
            onPressed: _cubit.pickRandomName,
            child: const Text('Pick a random name'),
          );
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return button;
            case ConnectionState.waiting:
              return button;
            case ConnectionState.active:
              return Column(
                children: [
                  Text(snapshot.data ?? ''),
                  button,
                ],
              );
            case ConnectionState.done:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
