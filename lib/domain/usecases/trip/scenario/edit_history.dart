import 'package:either_dart/either.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class EditHistoryUseCase {
  final HistoryRepository _repository;

  EditHistoryUseCase(this._repository);

  Future<Result<void>> call({
    required int historyId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
  }) async {
    final tasks = <Future<Result<void>> Function()>[
      () => _validation(placeName: placeName, description: description),
      () => _updateData(
        historyId: historyId,
        placeName: placeName,
        description: description,
        visitedAt: visitedAt,
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

  Future<Result<void>> _updateData({
    required int historyId,
    required String placeName,
    required String description,
    required DateTime visitedAt,
  }) async {
    try {
      await _repository.updateHistory(
        historyId: historyId,
        placeName: placeName,
        description: description,
        visitedAt: visitedAt,
      );
    } catch (error) {
      return Left(Failure(message: 'modifying history fails'));
    }
    return Right(null);
  }
}
