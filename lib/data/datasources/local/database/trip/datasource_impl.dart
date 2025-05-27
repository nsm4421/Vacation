import 'package:drift/drift.dart';
import 'package:vacation/data/models/export.dart';

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
  Future<int> insertTrip({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return await _tripDao.insertTrip(
      tripName: tripName,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<Iterable<FetchTripModel>> fetchAllTrips() async {
    return await _tripDao.getAllTrips().then(
      (res) => res.map(
        (e) => FetchTripModel(
          id: e.id,
          tripName: e.tripName,
          startDate: e.startDate,
          endDate: e.endDate,
        ),
      ),
    );
  }

  @override
  Future<bool> updateTrip({
    required int id,
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final trip = await _tripDao.getTripById(id);
    if (trip == null) throw Exception('trip entity not found with id $id');
    return await _tripDao.updateTrip(
      trip.copyWith(tripName: tripName, startDate: startDate, endDate: endDate),
    );
  }

  @override
  Future<int> deleteTripById(int id) async {
    return await _tripDao.deleteTrip(id);
  }
}
