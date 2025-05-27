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
    double? latitude,
    double? longitude,
  }) => into(historyTable).insert(
    HistoryTableCompanion(
      tripId: Value(tripId),
      placeName: Value(placeName),
      description: Value(description),
      visitedAt: Value(visitedAt),
      latitude: Value(latitude),
      longitude: Value(longitude),
    ),
  );

  // READ
  Future<List<HistoryTableData>> getAllHistories() =>
      select(historyTable).get();

  Future<List<HistoryTableData>> getHistoriesByTripId(int tripId) =>
      (select(historyTable)..where((h) => h.tripId.equals(tripId))).get();

  Future<HistoryTableData?> getHistoryById(int id) =>
      (select(historyTable)..where((h) => h.id.equals(id))).getSingleOrNull();

  // UPDATE
  Future<bool> updateHistory(HistoryTableData history) =>
      update(historyTable).replace(history);

  // DELETE
  Future<int> deleteHistory(int id) =>
      (delete(historyTable)..where((h) => h.id.equals(id))).go();
}
