import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:kebede_ai/modules/Prompt/domain/usecases/prompt_usecase.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../../core/error/failure.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
part 'prompt_event.dart';
part 'prompt_state.dart';

@injectable
class PromptBloc extends Bloc<PromptEvent, PromptState> {
  final SpeechToText _speechToText;
  final PromptUsecase _promptUsecase;
  final FlutterTts _flutterTts;
  PromptBloc(this._promptUsecase, this._flutterTts, this._speechToText)
      : super(KebedeLostInThougt()) {
    _initListening();

    on<TriggerErrorEvent>(
        (event, emit) => emit(PromptError(error: event.error)));
    on<TriggerThinkingEvent>((event, emit) => emit(KebedeThinking()));
    on<TriggerListenEvent>((event, emit) => emit(KebedeListening()));
    on<TriggerLostInThougtEvent>((event, emit) => emit(KebedeLostInThougt()));
    on<TriggerSpeakEvent>((event, emit) => emit(KebedeSpeaking()));
    on<SpeakEvent>((event, emit) async => await _onSpeakEvent(event, emit));
    on<StopSpeakEvent>((event, emit) async => await _stopListening());
  }

  _onSpeakEvent(SpeakEvent event, Emitter<PromptState> emit) async {
    // listen to the user speech.
    emit(KebedeListening());
    await _speechToText.listen(
        onResult: (SpeechRecognitionResult result) async {
      // for now we want only the last result , so lets check that in
      if (result.finalResult) {
        // this is supposed to be a loading emit
        add(TriggerThinkingEvent());
        // network call
        final response =
            await _promptUsecase(result.alternates.last.recognizedWords);

        response.fold((error) {
          add(TriggerErrorEvent(_handleError(error)));
          // emit(_handleError(error));
        }, (data) {
          // setup the male accent voice and locale
          _setupVoice().then((value) {
            // then speak
            add(TriggerSpeakEvent());
            _speak(data.text ?? "humm i dont know what you asked");
            // handle the event when the speaking ended up
            _onSpeakEnded(() {
              add(TriggerLostInThougtEvent());
            });
          });
        });
      }
    });
  }

  //
  String? _handleError(Failure error) {
    if (error is ServerFailure) {
      return error.message;
    } else if (error is CacheFailure) {
      return error.message;
    }
    return "Something went wrong please try again latter";
  }

  void _initListening() async {
    await _speechToText.initialize(debugLogging: true);
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
  }

  void _speak(String text) {
    _flutterTts.speak(text);
  }

  Future<void> _setupVoice() async {
    await _flutterTts
        .setVoice({'name': 'es-es-x-ana#male_2-local', 'locale': 'es-ES'});
  }

  void _onSpeakEnded(void Function() func) {
    _flutterTts.setCompletionHandler(func);
  }

  @override
  Future<void> close() async {
    await _speechToText.cancel();
    return super.close();
  }
}
