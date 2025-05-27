import 'package:vacation/domain/entities/export.dart';

abstract interface class TripRepository {
  Future<int> createTrip({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<List<TripEntity>> fetchAllTrips();

  Future<bool> updateTrip({
    required int id,
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<int> deleteTripById(int id);
}
