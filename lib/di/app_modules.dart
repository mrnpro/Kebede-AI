import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart';

@module
abstract class AppModules {
  @injectable
  SpeechToText get getspeechtoTextInstance => SpeechToText();
  @injectable
  http.Client get httpi => http.Client();

  @injectable
  FlutterTts get flutterTts => FlutterTts();
}
