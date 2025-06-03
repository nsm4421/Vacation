import 'package:drift/drift.dart';
import '../db/local_db.dart';
import '../table/history.dart';

part 'history.g.dart';

@DriftAccessor(tables: [HistoryTable])
class HistoryDao extends DatabaseAccessor<LocalDatabase>
    with _$HistoryDaoMixin {
  HistoryDao(super.db);

  // CREATE
  Future<int> insertHistory({
    required int tripId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
    required List<String> images,
    double? latitude,
    double? longitude,
  }) async {
    final data = HistoryTableCompanion(
      tripId: Value(tripId),
      placeName: Value(placeName),
      description: Value(description),
      imagesJson: Value(images),
      visitedAt: Value(visitedAt),
      latitude: Value(latitude),
      longitude: Value(longitude),
    );
    return await into(historyTable).insert(data);
  }

  // READ
  Future<List<HistoryTableData>> getAllHistories() async =>
      await select(historyTable).get();

  Future<List<HistoryTableData>> getHistoriesByTripId(int tripId) async =>
      await (select(historyTable)..where((h) => h.tripId.equals(tripId))).get();

  Future<HistoryTableData?> getHistoryById(int id) async =>
      await (select(historyTable)
        ..where((h) => h.id.equals(id))).getSingleOrNull();

  // UPDATE
  Future<bool> updateHistory({
    required int historyId,
    String? placeName,
    String? description,
    DateTime? visitedAt,
    List<String>? images,
  }) async {
    var temp = await getHistoryById(historyId);
    if (temp == null) {
      throw Exception('not found history with id $historyId');
    }
    temp = temp.copyWith(
      placeName: placeName,
      description: description,
      imagesJson: images,
      visitedAt: visitedAt,
    );
    return await update(historyTable).replace(temp);
  }

  // DELETE
  Future<int> deleteHistory(int id) async =>
      await (delete(historyTable)..where((h) => h.id.equals(id))).go();
}
