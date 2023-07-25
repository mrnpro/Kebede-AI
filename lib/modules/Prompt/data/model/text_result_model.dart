import '../../domain/entities/text_result_entity.dart';

class TextResultModel extends TextResultEntity {
  const TextResultModel(super.text);
  factory TextResultModel.fromJson(json) =>
      TextResultModel(json['generations'][0]['text']);
}
