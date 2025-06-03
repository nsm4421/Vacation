import 'package:injectable/injectable.dart';
import 'package:vacation/data/datasources/export.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/repositories/export.dart';
import '../image/image_repository_impl.dart';

@LazySingleton(as: HistoryRepository)
class HistoryRepositoryImpl extends $ImageRepositoryImpl
    implements HistoryRepository {
  final LocalHistoryDataSource _localDataSource;

  HistoryRepositoryImpl({
    required LocalHistoryDataSource localDataSource,
    required LocalStorage localStorage,
  }) : _localDataSource = localDataSource,
       super(localStorage);

  @override
  Future<HistoryEntity> createHistory({
    required int tripId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
    required List<String> images,
    double? latitude,
    double? longitude,
  }) async {
    return await _localDataSource
        .insertHistory(
          tripId: tripId,
          placeName: placeName,
          description: description,
          visitedAt: visitedAt,
          latitude: latitude,
          longitude: longitude,
          images: images,
        )
        .then(HistoryEntity.from);
  }

  @override
  Future<List<HistoryEntity>> fetchAllHistoriesByTripId(int tripId) async {
    return await _localDataSource
        .fetchAllHistoriesByTripId(tripId)
        .then((res) => res.map(HistoryEntity.from).toList());
  }

  @override
  Future<HistoryEntity> updateHistory({
    required int historyId,
    String? placeName,
    String? description,
    DateTime? visitedAt,
    List<String>? images,
  }) async {
    return await _localDataSource
        .updateHistory(
          historyId: historyId,
          placeName: placeName,
          description: description,
          visitedAt: visitedAt,
          images: images,
        )
        .then(HistoryEntity.from);
  }

  @override
  Future<int> deleteHistoryById(int historyId) async {
    return await _localDataSource.deleteHistoryById(historyId);
  }
}
