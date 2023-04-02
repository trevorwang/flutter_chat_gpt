import 'package:collection/collection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../conf/config.dart';
import '../data/message.dart';

class MessageList extends StateNotifier<List<Message>> {
  MessageList([List<Message>? messages]) : super(messages ?? []);
  void newMessage(
    String content,
    Role role, {
    String? id,
  }) {
    state = [
      ...state,
      Message(
        content: content,
        id: id ?? uuid.v4(),
        role: role,
      )
    ];
  }

  void newStreamMessage(String streamText, Role role, String id) {
    final msg = state.firstWhereOrNull((element) => element.id == id);

    if (msg != null) {
      state = [
        ...state.where((element) => element.id != id),
        msg.copyWith(content: msg.content + streamText),
      ];
    } else {
      state = [
        ...state,
        Message(
          content: streamText,
          id: id,
          role: role,
        )
      ];
    }
  }
}
