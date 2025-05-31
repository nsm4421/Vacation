import 'package:injectable/injectable.dart';
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
abstract class RemoteDataSourceModule {}
