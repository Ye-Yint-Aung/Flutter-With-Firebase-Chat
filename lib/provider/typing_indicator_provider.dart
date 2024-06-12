import 'package:flutter_riverpod/flutter_riverpod.dart';

class TypingIndicatorChangeProvider extends StateNotifier<bool> {
  Future _init() async {
    state = false;
  }

  TypingIndicatorChangeProvider() : super(false) {
    _init();
  }

  isTyping(bool onTap) {
    state = onTap;
  }
}

final typingIndicatorChangeProvider = StateNotifierProvider<TypingIndicatorChangeProvider, bool>(
      (ref) => TypingIndicatorChangeProvider(),
);