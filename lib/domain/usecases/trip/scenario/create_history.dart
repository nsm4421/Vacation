import 'package:either_dart/either.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class CreateHistoryUseCase {
  final HistoryRepository _repository;

  CreateHistoryUseCase(this._repository);

  Future<Result<int>> call({
    required int tripId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
    double? latitude,
    double? longitude,
  }) async {
    if (placeName.isEmpty) {
      return Left(Failure(message: "place name is not given"));
    } else if (description.isEmpty) {
      return Left(Failure(message: "description is not given"));
    }
    return await _repository
        .createHistory(
          tripId: tripId,
          placeName: placeName,
          description: description,
          visitedAt: visitedAt,
          latitude: latitude,
          longitude: longitude,
        )
        .then(Right.new);
  }
}
