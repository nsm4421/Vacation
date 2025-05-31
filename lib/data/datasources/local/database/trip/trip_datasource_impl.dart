import 'package:logger/logger.dart';
import 'package:vacation/data/models/export.dart';

import '../schema/dao/trip.dart';

part 'trip_datasource.dart';

class LocalTripDataSourceImpl implements LocalTripDataSource {
  final TripDao _tripDao;
  final Logger? _logger;

  LocalTripDataSourceImpl(this._tripDao, {Logger? logger}) : _logger = logger;

  @override
  Future<int> insertTrip({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    String? thumbnail,
  }) async {
    _logger?.d(
      'tripName:$tripName|thumbnail:$thumbnail|date:$startDate~$endDate',
    );
    return await _tripDao.insertTrip(
      tripName: tripName,
      startDate: startDate,
      endDate: endDate,
      thumbnail: thumbnail,
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
          thumbnail: e.thumbnail
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
    String? thumbnail,
  }) async {
    final trip = await _tripDao.getTripById(id);
    if (trip == null) throw Exception('trip not found with id $id');
    return await _tripDao.updateTrip(
      id: id,
      tripName: tripName,
      startDate: startDate,
      endDate: endDate,
      thumbnail: thumbnail,
    );
  }

  @override
  Future<int> deleteTripById(int id) async {
    return await _tripDao.deleteTrip(id);
  }
}
