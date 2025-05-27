import 'package:vacation/domain/entities/export.dart';

abstract interface class HistoryRepository {
  Future<int> createHistory({
    required int tripId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
    double? latitude,
    double? longitude,
  });

  Future<bool> updateHistory({
    required int historyId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
  });

  Future<List<HistoryEntity>> fetchAllHistoriesByTripId(int tripId);

  Future<int> deleteHistoryById(int historyId);
}
