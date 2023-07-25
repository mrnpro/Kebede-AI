part of 'prompt_bloc.dart';

abstract class PromptState extends Equatable {
  const PromptState();

  @override
  List<Object?> get props => [];
}

class KebedeLostInThougt extends PromptState {}

class KebedeListening extends PromptState {}

class KebedeThinking extends PromptState {}

class KebedeSpeaking extends PromptState {}

class PromptError extends PromptState {
  final String? error;

  const PromptError({this.error});
  @override
  List<Object?> get props => [error];
}
