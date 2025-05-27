import 'package:drift/drift.dart';

import 'trip.dart';

class HistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tripId =>
      integer().references(TripTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get placeName => text()();

  TextColumn get description => text()();

  DateTimeColumn get visitedAt => dateTime()();

  RealColumn get latitude => real().nullable()();

  RealColumn get longitude => real().nullable()();
}
