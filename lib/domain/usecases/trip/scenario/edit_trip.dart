import 'package:either_dart/either.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class EditTripUseCase {
  final TripRepository _repository;

  EditTripUseCase(this._repository);

  Future<Result<void>> call({
    required int id,
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final tasks = <Future<Result<void>> Function()>[
      () => _validation(
        tripName: tripName,
        startDate: startDate,
        endDate: endDate,
      ),
      () => _updateData(
        id: id,
        tripName: tripName,
        startDate: startDate,
        endDate: endDate,
      ),
    ];

    for (final task in tasks) {
      final result = await task();
      if (result.isLeft) return result;
    }

    return Right(null);
  }

  Future<Result<void>> _validation({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    if (tripName.isEmpty) {
      return Left(Failure(message: "trip name is not given"));
    } else if (startDate.isAfter(endDate)) {
      return Left(Failure(message: "start date can't be after than end date!"));
    }
    return Right(null);
  }

  Future<Result<void>> _updateData({
    required int id,
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      await _repository.updateTrip(
        id: id,
        tripName: tripName,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (error) {
      return Left(Failure(message: 'modifying trip fails'));
    }
    return Right(null);
  }
}
