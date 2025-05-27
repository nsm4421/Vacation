import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class DeleteTripUseCase {
  final TripRepository _repository;

  DeleteTripUseCase(this._repository);

  Future<Result<void>> call(int id) async {
    try {
      return await _repository.deleteTripById(id).then((_) => Right(null));
    } catch (error) {
      log(error.toString());
      return Left(Failure(message: 'delete trip fails'));
    }
  }
}
