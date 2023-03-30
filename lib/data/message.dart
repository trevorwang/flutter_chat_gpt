import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.g.dart';
part 'message.freezed.dart';

@immutable
@freezed
class Message with _$Message {
  factory Message({
    required String content,
    required String id,
    required Role role,
  }) = _Message;
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@JsonEnum()
enum Role { gpt, user }
