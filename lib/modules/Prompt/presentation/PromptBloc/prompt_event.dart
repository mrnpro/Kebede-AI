part of 'prompt_bloc.dart';

abstract class PromptEvent extends Equatable {
  const PromptEvent();

  @override
  List<Object> get props => [];
}

class TriggerLostInThougtEvent extends PromptEvent {}

class TriggerSpeakEvent extends PromptEvent {}

class TriggerListenEvent extends PromptEvent {}

class TriggerThinkingEvent extends PromptEvent {}

class SpeakEvent extends PromptEvent {
  const SpeakEvent();
  @override
  List<Object> get props => [];
}

class StopSpeakEvent extends PromptEvent {}
