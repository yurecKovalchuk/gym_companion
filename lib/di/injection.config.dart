// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/repository/exercises_repository_impl.dart' as _i9;
import '../datasource/auth_datasource.dart' as _i5;
import '../datasource/datasource.dart' as _i7;
import '../datasource/local_datasource.dart' as _i3;
import '../datasource/remote_datasource.dart' as _i6;
import '../datasource/sqlite_datasource.dart' as _i4;
import '../domain/domain.dart' as _i8;
import 'injection.dart' as _i10;

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
    final registerModule = _$RegisterModule();
    gh.factory<_i3.LocalDataSource>(() => _i3.LocalDataSource());
    gh.factory<_i4.SQLiteDataSource>(() => _i4.SQLiteDataSource());
    gh.factory<Uri>(
      () => registerModule.baseUrl,
      instanceName: 'baseUrl',
    );
    gh.factory<_i5.AuthDataSource>(() => _i5.AuthDataSource(baseUrl: gh<Uri>(instanceName: 'baseUrl')));
    gh.factory<_i6.RemoteDataSource>(() => _i6.RemoteDataSource(
          gh<Uri>(instanceName: 'baseUrl'),
          gh<_i7.LocalDataSource>(),
        ));
    gh.factory<_i8.ExercisesRepository>(() => _i9.ExercisesRepositoryImpl(
          gh<_i7.LocalDataSource>(),
          gh<_i7.RemoteDataSource>(),
          gh<_i7.AuthDataSource>(),
          gh<_i7.SQLiteDataSource>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}
