part of 'prompt_bloc.dart';

abstract class PromptEvent extends Equatable {
  const PromptEvent();

  @override
  List<Object?> get props => [];
}

// those trigger methods mostly used in the bloc class , when we are not able to emit the states...
class TriggerLostInThougtEvent extends PromptEvent {}

class TriggerSpeakEvent extends PromptEvent {}

class TriggerListenEvent extends PromptEvent {}

class TriggerThinkingEvent extends PromptEvent {}

class TriggerErrorEvent extends PromptEvent {
  final String? error;

  const TriggerErrorEvent(this.error);
  @override
  List<Object?> get props => [error];
}

//
// those event located under this comment are going to be called on the ui layer .
class SpeakEvent extends PromptEvent {
  const SpeakEvent();
  @override
  List<Object> get props => [];
}

class StopSpeakEvent extends PromptEvent {}
