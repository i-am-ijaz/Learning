// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/extensions/extensions.dart';

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class PersonsAction implements LoadAction {
  final PersonsUrl url;

  const PersonsAction({
    required this.url,
  });
}

@immutable
class Person {
  final String name;
  final int age;

  const Person({
    required this.name,
    required this.age,
  });

  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        age = json['age'] as int;

  @override
  String toString() => 'Person (name = $name, age = $age)';
}

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((res) => res.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then(
      (list) => list.map(
        (e) => Person.fromJson(e),
      ),
    );

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  const FetchResult({
    required this.persons,
    required this.isRetrievedFromCache,
  });

  @override
  String toString() =>
      'FetchResult(persons: $persons, isRetrievedFromCache: $isRetrievedFromCache)';
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonsUrl, Iterable<Person>> _cache = {};

  PersonsBloc() : super(null) {
    on<PersonsAction>(
      (event, emit) async {
        final url = event.url;
        if (_cache.containsKey(url)) {
          final cachedPersons = _cache[url]!;

          final result = FetchResult(
            persons: cachedPersons,
            isRetrievedFromCache: true,
          );
          emit(result);
        } else {
          final persons = await getPersons(url.urlString);
          _cache[url] = persons;
          final result = FetchResult(
            persons: persons,
            isRetrievedFromCache: false,
          );
          emit(result);
        }
      },
    );
  }
}

enum PersonsUrl {
  persons1,
  persons2,
}

class BlocHomePage extends StatefulWidget {
  const BlocHomePage({super.key});

  @override
  State<BlocHomePage> createState() => _BlocHomePageState();
}

class _BlocHomePageState extends State<BlocHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.read<PersonsBloc>().add(
                        const PersonsAction(
                          url: PersonsUrl.persons1,
                        ),
                      );
                },
                child: const Text('Load Json 1'),
              ),
              TextButton(
                onPressed: () {
                  context.read<PersonsBloc>().add(
                        const PersonsAction(
                          url: PersonsUrl.persons2,
                        ),
                      );
                },
                child: const Text('Load Json 2'),
              ),
            ],
          ),
          BlocBuilder<PersonsBloc, FetchResult?>(
            buildWhen: (previousResult, currentResult) {
              return previousResult?.persons != currentResult?.persons;
            },
            builder: (context, fetchResult) {
              fetchResult?.log();
              final persons = fetchResult?.persons;

              if (persons == null) return const SizedBox();

              return Expanded(
                child: ListView.builder(
                  itemCount: persons.length,
                  itemBuilder: (ctx, index) {
                    final person = persons[index]!;

                    return ListTile(
                      title: Text(person.name),
                      subtitle: Text(person.age.toString()),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
