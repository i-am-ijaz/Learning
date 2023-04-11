// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen onClose;
  final UpdateLoadingScreen onUpdate;

  const LoadingScreenController({
    required this.onClose,
    required this.onUpdate,
  });

  
}
