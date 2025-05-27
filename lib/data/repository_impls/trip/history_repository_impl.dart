import 'package:injectable/injectable.dart';
import 'package:vacation/data/datasources/export.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/repositories/export.dart';

@LazySingleton(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  final LocalHistoryDataSource _localDataSource;

  HistoryRepositoryImpl(this._localDataSource);

  @override
  Future<int> createHistory({
    required int tripId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
    double? latitude,
    double? longitude,
  }) async {
    return await _localDataSource.insertHistory(
      tripId: tripId,
      placeName: placeName,
      description: description,
      visitedAt: visitedAt,
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<List<HistoryEntity>> fetchAllHistoriesByTripId(int tripId) async {
    return await _localDataSource
        .fetchAllHistoriesByTripId(tripId)
        .then((res) => res.map(HistoryEntity.from).toList());
  }

  @override
  Future<bool> updateHistory({
    required int historyId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
  }) async {
    return await _localDataSource.updateHistory(
      historyId: historyId,
      placeName: placeName,
      description: description,
      visitedAt: visitedAt,
    );
  }

  @override
  Future<int> deleteHistoryById(int historyId) async {
    return await _localDataSource.deleteHistoryById(historyId);
  }
}
