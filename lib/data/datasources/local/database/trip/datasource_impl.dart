import 'package:drift/drift.dart';

import '../schema/dao/history.dart';
import '../schema/dao/trip.dart';
import '../schema/db/local_db.dart';

part 'datasource.dart';

class LocalTripDataSourceImpl implements LocalTripDataSource {
  final TripDao _tripDao;
  final HistoryDao _historyDao;

  LocalTripDataSourceImpl({
    required TripDao tripDao,
    required HistoryDao historyDao,
  }) : _tripDao = tripDao,
       _historyDao = historyDao;

  @override
  Future<int> insertTripAndReturnId({
    required String tripName,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _tripDao.insertTrip(
      TripTableCompanion(
        tripName: Value(tripName),
        startDate: Value(startDate ?? DateTime.now()),
        endDate: Value(endDate ?? DateTime(9999, 12, 31)),
      ),
    );
  }
}
