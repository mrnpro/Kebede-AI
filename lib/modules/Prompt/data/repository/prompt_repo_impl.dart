import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:kebede_ai/core/error/failure.dart';
import 'package:kebede_ai/modules/Prompt/data/datasources/RemoteDataSource/remote_data_source.dart';
import 'package:kebede_ai/modules/Prompt/domain/entities/text_result_entity.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repository/prompt_repo.dart';

@LazySingleton(as: PromptRepo)
class PromptRepoImpl implements PromptRepo {
  final PromptRemoteDataSource _promptRemoteDataSource;

  PromptRepoImpl(this._promptRemoteDataSource);
  @override
  Future<Either<Failure, TextResultEntity>> generate(String text) async {
    try {
      final textResultModel = await _promptRemoteDataSource.generate(text);
      return Right(textResultModel);
    } on ServerException catch (e) {
      final failureType = switch (e) {
        (ServerException serverException)
            when serverException.statusCode == 401 =>
          const ServerFailure(message: "invalid api key"),
        (ServerException serverException)
            when serverException.statusCode == 500 =>
          const ServerFailure(message: "internal server error"),
        (_) => const ServerFailure(message: "something went wrong")
      };
      return Left(failureType);
    } catch (e) {
      print(e);
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
