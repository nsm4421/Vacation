import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:vacation/env.dart';

import '../dao/history.dart';
import '../dao/trip.dart';
import '../table/history.dart';
import '../table/trip.dart';

part 'local_db.g.dart';

@DriftDatabase(
  tables: [TripTable, HistoryTable],
  daos: [TripDao, HistoryDao],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase()
    : super(
        // open connection
        LazyDatabase(() async {
          final dbFolder = await getApplicationDocumentsDirectory();
          final file = File(p.join(dbFolder.path, Env.dbName));
          return NativeDatabase(file);
        }),
      );

  @override
  int get schemaVersion => 1;
}

@module
abstract class LocalDatabaseModule {
  @lazySingleton
  LocalDatabase db() => LocalDatabase();
}
