import 'package:either_dart/either.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class FetchAllHistoriesByTripIdUseCase {
  final HistoryRepository _repository;

  FetchAllHistoriesByTripIdUseCase(this._repository);

  Future<Result<List<HistoryEntity>>> call(int tripId) async {
    try {
      return await _repository
          .fetchAllHistoriesByTripId(tripId)
          .then(Right.new);
    } catch (error) {
      return Left(Failure(message: 'fetching fails'));
    }
  }
}
