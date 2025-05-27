import 'package:injectable/injectable.dart';
import 'package:vacation/domain/repositories/export.dart';

import 'scenario/create_history.dart';
import 'scenario/fetch_all_histories_by_trip_id.dart';
import 'scenario/edit_history.dart';
import 'scenario/delete_history.dart';

@lazySingleton
class HistoryUseCase {
  final HistoryRepository _repository;

  HistoryUseCase(this._repository);

  @lazySingleton
  CreateHistoryUseCase get createHistory => CreateHistoryUseCase(_repository);

  @lazySingleton
  FetchAllHistoriesByTripIdUseCase get fetchAllHistoriesByTripId =>
      FetchAllHistoriesByTripIdUseCase(_repository);

  @lazySingleton
  EditHistoryUseCase get editHistory => EditHistoryUseCase(_repository);

  @lazySingleton
  DeleteHistoryUseCase get deleteHistory => DeleteHistoryUseCase(_repository);
}
