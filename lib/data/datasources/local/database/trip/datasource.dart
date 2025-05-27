part of 'datasource_impl.dart';

abstract interface class LocalTripDataSource {
  Future<int> insertTrip({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<Iterable<FetchTripModel>> fetchAllTrips();

  Future<bool> updateTrip({
    required int id,
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<int> deleteTripById(int id);
}
