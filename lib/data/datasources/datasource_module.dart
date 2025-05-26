import 'package:injectable/injectable.dart';
import 'local/database/schema/db/local_db.dart';
import 'local/database/trip/datasource_impl.dart';

@module
abstract class LocalDataSourceModule {
  final LocalDatabase _db = LocalDatabase();

  @lazySingleton
  LocalTripDataSource get trip => LocalTripDataSourceImpl(
    tripDao: _db.tripDao,
    historyDao: _db.historyDao,
  );
}

@module
abstract class RemoteDataSourceModule {}
