import 'package:either_dart/either.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class CreateHistoryUseCase {
  final HistoryRepository _repository;

  CreateHistoryUseCase(this._repository);

  Future<Result<void>> call({
    required int tripId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
    double? latitude,
    double? longitude,
  }) async {
    final tasks = <Future<Result<void>> Function()>[
      () => _validation(placeName: placeName, description: description),
      () => _insertData(
        tripId: tripId,
        placeName: placeName,
        description: description,
        visitedAt: visitedAt,
        latitude: latitude,
        longitude: longitude,
      ),
    ];

    for (final task in tasks) {
      final result = await task();
      if (result.isLeft) return result;
    }

    return Right(null);
  }

  Future<Result<void>> _validation({
    required String placeName,
    required String description,
  }) async {
    if (placeName.isEmpty) {
      return Left(Failure(message: "place name is not given"));
    } else if (description.isEmpty) {
      return Left(Failure(message: "description is not given"));
    }
    return Right(null);
  }

  Future<Result<void>> _insertData({
    required int tripId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
    double? latitude,
    double? longitude,
  }) async {
    try {
      await _repository.createHistory(
        tripId: tripId,
        placeName: placeName,
        description: description,
        visitedAt: visitedAt,
        latitude: latitude,
        longitude: longitude,
      );
    } catch (error) {
      return Left(Failure(message: 'inserting data in db fails'));
    }
    return Right(null);
  }
}
