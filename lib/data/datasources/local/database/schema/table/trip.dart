import 'package:drift/drift.dart';

class TripTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get tripName => text()();

  DateTimeColumn get startDate =>
      dateTime().withDefault(Constant(DateTime.now()))();

  DateTimeColumn get endDate =>
      dateTime().withDefault(Constant(DateTime.now().add(Duration(days: 7))))();
}
