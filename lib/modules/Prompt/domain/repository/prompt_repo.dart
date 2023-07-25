import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/text_result_entity.dart';

abstract class PromptRepo {
  Future<Either<Failure, TextResultEntity>> generate(String prompt);
}
