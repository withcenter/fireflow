import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

import 'package:fireflow/fireflow.dart';

Future<String> queryGpt({
  required String prompt,
  String? model,
  double? temperature,
  int? length,
}) async {
  // Add your function code here!
  final data = {
    'prompt': prompt,
    'max_tokens': length ?? 2048,
    'temperature': temperature ?? 0.5,
  };

  model ??= "text-davinci-003";

  final headers = {'Authorization': 'Bearer ${AppService.instance.keys.openAiApiKey}', 'Content-Type': 'application/json'};
  final request = Request(
    'POST',
    Uri.parse('https://api.openai.com/v1/engines/$model/completions'),
  );
  request.body = json.encode(data);
  request.headers.addAll(headers);

  final httpResponse = await request.send();

  if (httpResponse.statusCode == 200) {
    final jsonResponse = json.decode(await httpResponse.stream.bytesToString());
    return jsonResponse['choices'][0]['text'];
  } else {
    debugPrint(httpResponse.reasonPhrase);
    return '';
  }
}
