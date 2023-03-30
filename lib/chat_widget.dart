import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:markdown/markdown.dart' as md;

import 'data/message.dart';
import 'state/message_state.dart';

final messageListProvider = StateNotifierProvider<MessageList, List<Message>>(
  (ref) {
    return MessageList();
  },
);

class ChatWidget extends HookConsumerWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final messages = ref.watch(messageListProvider);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('GPT')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView(
                children: [
                  for (var i = 0; i < messages.length; i++) ...[
                    MessageItemWidget(message: messages[i])
                  ],
                ],
              )),
              TextField(
                key: UniqueKey(),
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'What can I do for you?',
                  suffix: IconButton(
                      onPressed: () {
                        submitTextValue(ref, controller.text, controller);
                      },
                      icon: const Icon(Icons.send)),
                ),
                onSubmitted: (value) {
                  submitTextValue(ref, value, controller);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendRequest(WidgetRef ref, String text) async {
    // final data = await api.sendChat(ChatRequest(message: text));
    // log.info(data);
    // ref
    // .read(messageListProvider.notifier)
    // .newMessage(data.message.trim(), Role.gpt);
  }

  void submitTextValue(
      WidgetRef ref, String value, TextEditingController controller) {
    ref.read(messageListProvider.notifier).newMessage(value, Role.user);
    controller.clear();
    sendRequest(ref, value);
  }
}

class MessageItemWidget extends StatelessWidget {
  final Message message;
  const MessageItemWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: message.role == Role.gpt
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (message.role == Role.user)
            const SizedBox(
              width: 40,
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.black12,
              ),
              child: MarkdownBody(
                data: message.content,
                extensionSet: md.ExtensionSet.gitHubWeb,
              ),
            ),
          ),
          if (message.role == Role.gpt)
            const SizedBox(
              width: 40,
            ),
        ],
      ),
    );
  }
}
