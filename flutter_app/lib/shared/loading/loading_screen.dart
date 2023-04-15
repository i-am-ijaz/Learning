import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/shared/loading/loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreen._();
  static final _shared = LoadingScreen._();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (_controller?.onUpdate(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(
        context: context,
        textToShow: text,
      );
    }
  }

  void hide() {
    _controller?.onClose();
    _controller = null;
  }

  LoadingScreenController _showOverlay({
    required BuildContext context,
    required String textToShow,
  }) {
    final text = StreamController<String>();
    text.add(textToShow);

    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.5,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      StreamBuilder<String>(
                        stream: text.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.requireData,
                              textAlign: TextAlign.center,
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadingScreenController(
      onClose: () {
        text.close();
        overlay.remove();
        return true;
      },
      onUpdate: (textToShow) {
        text.add(textToShow);
        return true;
      },
    );
  }
}
