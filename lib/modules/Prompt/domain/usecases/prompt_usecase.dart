import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kebede_ai/core/usecases/usecase.dart';

import '../../../../core/error/failure.dart';
import '../entities/text_result_entity.dart';
import '../repository/prompt_repo.dart';

@lazySingleton
class PromptUsecase extends UseCase<TextResultEntity, String> {
  final PromptRepo _promptRepo;

  PromptUsecase(this._promptRepo);

  @override
  Future<Either<Failure, TextResultEntity>> call(String params) async {
    return await _promptRepo.generate(params);
  }
}
