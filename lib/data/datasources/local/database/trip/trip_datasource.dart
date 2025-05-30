part of 'trip_datasource_impl.dart';

abstract interface class LocalTripDataSource {
  Future<int> insertTrip({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    String? thumbnail
  });

  Future<Iterable<FetchTripModel>> fetchAllTrips();

  Future<bool> updateTrip({
    required int id,
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    String? thumbnail
  });

  Future<int> deleteTripById(int id);
}
