import 'package:vacation/domain/entities/export.dart';
import '../image/image_repository.dart';

abstract interface class HistoryRepository implements ImageRepository {
  Future<HistoryEntity> createHistory({
    required int tripId,
    required String placeName,
    required String description,
    required List<String> images,
    required DateTime visitedAt,
    double? latitude,
    double? longitude,
  });

  Future<HistoryEntity> updateHistory({
    required int historyId,
    String? placeName,
    String? description,
    DateTime? visitedAt,
    List<String>? images,
  });

  Future<List<HistoryEntity>> fetchAllHistoriesByTripId(int tripId);

  Future<int> deleteHistoryById(int historyId);
}
