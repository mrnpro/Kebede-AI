// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_tts/flutter_tts.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:speech_to_text/speech_to_text.dart' as _i9;

import '../modules/Prompt/data/datasources/RemoteDataSource/remote_data_source.dart'
    as _i5;
import '../modules/Prompt/data/repository/prompt_repo_impl.dart' as _i7;
import '../modules/Prompt/domain/repository/prompt_repo.dart' as _i6;
import '../modules/Prompt/domain/usecases/prompt_usecase.dart' as _i8;
import '../modules/Prompt/presentation/PromptBloc/prompt_bloc.dart' as _i10;
import 'app_modules.dart' as _i11;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModules = _$AppModules();
    gh.factory<_i3.Client>(() => appModules.httpi);
    gh.factory<_i4.FlutterTts>(() => appModules.flutterTts);
    gh.lazySingleton<_i5.PromptRemoteDataSource>(
        () => _i5.PromptRemoteDataSourceImpl(gh<_i3.Client>()));
    gh.lazySingleton<_i6.PromptRepo>(
        () => _i7.PromptRepoImpl(gh<_i5.PromptRemoteDataSource>()));
    gh.lazySingleton<_i8.PromptUsecase>(
        () => _i8.PromptUsecase(gh<_i6.PromptRepo>()));
    gh.factory<_i9.SpeechToText>(() => appModules.getspeechtoTextInstance);
    gh.factory<_i10.PromptBloc>(() => _i10.PromptBloc(
          gh<_i8.PromptUsecase>(),
          gh<_i4.FlutterTts>(),
          gh<_i9.SpeechToText>(),
        ));
    return this;
  }
}

class _$AppModules extends _i11.AppModules {}
