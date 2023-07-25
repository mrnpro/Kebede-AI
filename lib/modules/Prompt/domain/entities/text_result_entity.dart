import 'package:equatable/equatable.dart';
class TextResultEntity extends Equatable {
  final String? text;

  const TextResultEntity(this.text);

  @override
  
  List<Object?> get props => [text];
}
