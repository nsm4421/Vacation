import 'package:drift/drift.dart';

import '../util/string_list_converter.dart';
import 'trip.dart';

class HistoryTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tripId =>
      integer().references(TripTable, #id, onDelete: KeyAction.cascade)();

  TextColumn get placeName => text()();

  TextColumn get description => text()();

  // drift라이브러리는 List<String>형태의 필드를 지원하지 않음
  // json string형태로 저장하는 방식을 사용하기 위해 mapper class를 직접 정의
  TextColumn get imagesJson => text().map(const StringListConverter())();

  DateTimeColumn get visitedAt => dateTime()();

  RealColumn get latitude => real().nullable()();

  RealColumn get longitude => real().nullable()();
}
