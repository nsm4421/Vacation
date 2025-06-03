import 'package:vacation/domain/entities/export.dart';

import '../image/image_repository.dart';

abstract interface class TripRepository implements ImageRepository {
  Future<int> createTrip({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    String? thumbnail,
  });

  Future<List<TripEntity>> fetchAllTrips();

  Future<bool> updateTrip({
    required int id,
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    String? thumbnail,
  });

  Future<int> deleteTripById(int id);
}
