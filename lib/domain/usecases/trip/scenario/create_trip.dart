import 'package:either_dart/either.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class CreateTripUseCase {
  final TripRepository _repository;

  CreateTripUseCase(this._repository);

  Future<Result<void>> call({
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
      () => _insertData(
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
    if (startDate.isAfter(endDate)) {
      return Left(Failure(message: "start date can't be after than end date!"));
    }
    return Right(null);
  }

  Future<Result<void>> _insertData({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      await _repository.createTrip(
        tripName: tripName,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (error) {
      return Left(Failure(message: 'inserting data in db fails'));
    }
    return Right(null);
  }
}
