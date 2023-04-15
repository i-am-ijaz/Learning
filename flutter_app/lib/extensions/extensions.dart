import 'dart:math' as math show Random;

import 'package:flutter_app/bloc/bloc_examples.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

extension UrlString on PersonsUrl {
  String get urlString {
    switch (this) {
      case PersonsUrl.persons1:
        return 'http://127.0.0.1:5500/api/persons_1.json';
      case PersonsUrl.persons2:
        return 'http://127.0.0.1:5500/api/persons_2.json';
    }
  }
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}
