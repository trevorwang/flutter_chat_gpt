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
}
