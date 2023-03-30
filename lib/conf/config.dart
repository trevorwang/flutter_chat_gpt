import 'package:flutter_chat_gpt/conf/env.dart';
import 'package:logger/logger.dart';
import 'package:openai_api/openai_api.dart';
import 'package:uuid/uuid.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

var uuid = const Uuid();

var openai = OpenaiClient(
  config: OpenaiConfig(
    apiKey: Env.apiKey,
    baseUrl: Env.baseUrl,
    httpProxy: Env.httpProxy,
  ),
);
