import 'package:injectable/injectable.dart';
import 'local/database/schema/db/local_db.dart';
import 'local/database/trip/history_datasource_impl.dart';
import 'local/database/trip/trip_datasource_impl.dart';

@module
abstract class LocalDataSourceModule {
  final LocalDatabase _db = LocalDatabase();

  @lazySingleton
  LocalTripDataSource get trip => LocalTripDataSourceImpl(_db.tripDao);

  @lazySingleton
  LocalHistoryDataSource get history =>
      LocalHistoryDataSourceImpl(_db.historyDao);
}

@module
abstract class RemoteDataSourceModule {}
