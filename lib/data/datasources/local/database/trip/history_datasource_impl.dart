import 'package:logger/logger.dart';
import 'package:vacation/data/models/export.dart';

import '../schema/dao/history.dart';

part 'history_datasource.dart';

class LocalHistoryDataSourceImpl implements LocalHistoryDataSource {
  final HistoryDao _historyDao;
  final Logger? _logger;

  LocalHistoryDataSourceImpl(this._historyDao, {Logger? logger})
    : _logger = logger;

  @override
  Future<int> insertHistory({
    required int tripId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
    double? latitude,
    double? longitude,
  }) async {
    _logger?.d(
      'tripId:$tripId|placeName:$placeName|visitedAt:$visitedAt|latitude:$latitude|longitude:$longitude',
    );
    return await _historyDao.insertHistory(
      tripId: tripId,
      placeName: placeName,
      description: description,
      visitedAt: visitedAt,
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<bool> updateHistory({
    required int historyId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
  }) async {
    final history = await _historyDao.getHistoryById(historyId);
    if (history == null) {
      throw Exception('history not found with id $historyId');
    }
    return await _historyDao.updateHistory(
      history.copyWith(
        placeName: placeName,
        description: description,
        visitedAt: visitedAt,
      ),
    );
  }

  @override
  Future<Iterable<FetchHistoryModel>> fetchAllHistoriesByTripId(
    int tripId,
  ) async {
    return await _historyDao
        .getHistoriesByTripId(tripId)
        .then(
          (res) => res.map(
            (e) => FetchHistoryModel(
              id: e.id,
              tripId: e.tripId,
              placeName: e.placeName,
              description: e.description,
              visitedAt: e.visitedAt,
            ),
          ),
        );
  }

  @override
  Future<int> deleteHistoryById(int historyId) async {
    return await _historyDao.deleteHistory(historyId);
  }
}
