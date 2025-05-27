import 'package:drift/drift.dart';
import '../db/local_db.dart';
import '../table/trip.dart';

part 'trip.g.dart';

@DriftAccessor(tables: [TripTable])
class TripDao extends DatabaseAccessor<LocalDatabase> with _$TripDaoMixin {
  TripDao(super.db);

  // Create
  Future<int> insertTrip({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  }) => into(tripTable).insert(
    TripTableCompanion(
      tripName: Value(tripName),
      startDate: Value(startDate),
      endDate: Value(endDate),
    ),
  );

  // Read
  Future<List<TripTableData>> getAllTrips() => select(tripTable).get();

  Future<TripTableData?> getTripById(int id) =>
      (select(tripTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  // Update
  Future<bool> updateTrip(TripTableData trip) =>
      update(tripTable).replace(trip);

  // Delete
  Future<int> deleteTrip(int id) =>
      (delete(tripTable)..where((t) => t.id.equals(id))).go();
}
