import 'package:vacation/data/models/export.dart';

import '../schema/dao/trip.dart';

part 'trip_datasource.dart';

class LocalTripDataSourceImpl implements LocalTripDataSource {
  final TripDao _tripDao;

  LocalTripDataSourceImpl(this._tripDao);

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
    if (trip == null) throw Exception('trip not found with id $id');
    return await _tripDao.updateTrip(
      trip.copyWith(tripName: tripName, startDate: startDate, endDate: endDate),
    );
  }

  @override
  Future<int> deleteTripById(int id) async {
    return await _tripDao.deleteTrip(id);
  }
}
