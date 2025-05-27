import 'package:either_dart/either.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class FetchAllTripsUseCase {
  final TripRepository _repository;

  FetchAllTripsUseCase(this._repository);

  Future<Result<List<TripEntity>>> call() async {
    try {
      return await _repository.fetchAllTrips().then(Right.new);
    } catch (error) {
      return Left(Failure(message: 'fetching fails'));
    }
  }
}
