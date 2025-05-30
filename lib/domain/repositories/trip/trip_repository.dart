import 'dart:io';

import 'package:vacation/domain/entities/export.dart';

abstract interface class TripRepository {
  /// database
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

  /// storage
  Future<String> saveThumbnail(File file);

  Future<String> changeThumbnail({
    required File file,
    required String originalPath,
  });

  Future<void> deleteThumbnail(String path);
}
