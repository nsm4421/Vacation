part of 'history_datasource_impl.dart';

abstract interface class LocalHistoryDataSource {
  Future<FetchHistoryModel> insertHistory({
    required int tripId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
    required List<String> images,
    double? latitude,
    double? longitude,
  });

  Future<FetchHistoryModel> updateHistory({
    required int historyId,
     String? placeName,
     String? description,
     DateTime? visitedAt,
     List<String>? images,
  });

  Future<FetchHistoryModel> findHistoryById(int historyId);

  Future<Iterable<FetchHistoryModel>> fetchAllHistoriesByTripId(int tripId);

  Future<int> deleteHistoryById(int historyId);
}
