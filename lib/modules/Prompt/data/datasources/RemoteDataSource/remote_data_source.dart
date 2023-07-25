import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:kebede_ai/core/config/apis.dart';
import 'package:kebede_ai/core/config/http_config.dart';
import 'package:kebede_ai/core/error/exceptions.dart';
import '../../model/text_result_model.dart';
import 'dart:convert';

abstract class PromptRemoteDataSource {
  Future<TextResultModel> generate(String prompt);
}

@LazySingleton(as: PromptRemoteDataSource)
class PromptRemoteDataSourceImpl implements PromptRemoteDataSource {
  final http.Client _client;

  PromptRemoteDataSourceImpl(this._client);
  @override
  Future<TextResultModel> generate(String text) async {
    final uri = Uri.parse(HttpConfig.cohereBaseUrl + Api.generate);
    var headers = {
      'Content-Type': 'application/json',
      'authorization': HttpConfig.cohereAuthKey
    };

    final body = {
      "prompt": text,
      "max_tokens": 100,
      "return_likelihoods": "NONE",
      "truncate": "END"
    };
    final response =
        await _client.post(uri, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {
      return TextResultModel.fromJson(jsonDecode(response.body));
    }

    throw ServerException(statusCode: response.statusCode);
  }
}
