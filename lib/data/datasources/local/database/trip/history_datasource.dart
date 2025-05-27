part of 'history_datasource_impl.dart';

abstract interface class LocalHistoryDataSource {
  Future<int> insertHistory({
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

  Future<Iterable<FetchHistoryModel>> fetchAllHistoriesByTripId(int tripId);

  Future<int> deleteHistoryById(int historyId);
}
