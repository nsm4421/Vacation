import 'package:logger/logger.dart';
import 'package:vacation/data/models/export.dart';

import '../schema/dao/history.dart';
import '../schema/db/local_db.dart';

part 'history_datasource.dart';

class LocalHistoryDataSourceImpl implements LocalHistoryDataSource {
  final HistoryDao _historyDao;
  final Logger? _logger;

  LocalHistoryDataSourceImpl(this._historyDao, {Logger? logger})
    : _logger = logger;

  @override
  Future<FetchHistoryModel> findHistoryById(int historyId) async {
    final fetched = await _historyDao.getHistoryById(historyId);
    if (fetched == null) {
      _logger?.w('history id $historyId not exist');
      throw Exception('not found exception');
    }
    return _convert(fetched);
  }

  @override
  Future<FetchHistoryModel> insertHistory({
    required int tripId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
    required List<String> images,
    double? latitude,
    double? longitude,
  }) async {
    _logger?.d(
      'tripId:$tripId|placeName:$placeName|visitedAt:$visitedAt|latitude:$latitude|longitude:$longitude',
    );
    final historyId = await _historyDao.insertHistory(
      tripId: tripId,
      placeName: placeName,
      description: description,
      visitedAt: visitedAt,
      latitude: latitude,
      longitude: longitude,
      images: images,
    );
    return await findHistoryById(historyId);
  }

  @override
  Future<FetchHistoryModel> updateHistory({
    required int historyId,
    String? placeName,
    String? description,
    DateTime? visitedAt,
    List<String>? images,
  }) async {
    final updated = await _historyDao.updateHistory(
      historyId: historyId,
      placeName: placeName,
      description: description,
      visitedAt: visitedAt,
      images: images,
    );
    if (!updated) {
      throw Exception('updating history fails');
    }
    return findHistoryById(historyId);
  }

  @override
  Future<Iterable<FetchHistoryModel>> fetchAllHistoriesByTripId(
    int tripId,
  ) async {
    return await _historyDao
        .getHistoriesByTripId(tripId)
        .then((res) => res.map(_convert));
  }

  @override
  Future<int> deleteHistoryById(int historyId) async {
    return await _historyDao.deleteHistory(historyId);
  }

  FetchHistoryModel _convert(HistoryTableData data) {
    return FetchHistoryModel(
      id: data.id,
      tripId: data.tripId,
      placeName: data.placeName,
      description: data.description,
      visitedAt: data.visitedAt,
      latitude: data.latitude,
      longitude: data.longitude,
      images: data.imagesJson,
    );
  }
}
