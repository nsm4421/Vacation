import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:vacation/data/datasources/remote/youtube/youtube_datasource_impl.dart';
import 'package:vacation/shared/export.dart';
import 'local/database/schema/db/local_db.dart';
import 'local/database/trip/history_datasource_impl.dart';
import 'local/database/trip/trip_datasource_impl.dart';
import 'local/storage/local_storage_impl.dart';

@module
abstract class LocalDataSourceModule with LoggerMixIn {
  final LocalDatabase _db = LocalDatabase();

  @lazySingleton
  LocalTripDataSource get tripDatabase =>
      LocalTripDataSourceImpl(_db.tripDao, logger: logger);

  @lazySingleton
  LocalHistoryDataSource get historyDatabase =>
      LocalHistoryDataSourceImpl(_db.historyDao, logger: logger);

  @lazySingleton
  LocalStorage get localStorage => LocalStorageImpl(logger: logger);
}

@module
abstract class RemoteDataSourceModule with LoggerMixIn {
  final Dio _dio = Dio();

  @lazySingleton
  RemoteYoutubeDataSource get youtube =>
      RemoteYoutubeDataSourceImpl(_dio, logger: logger);
}
