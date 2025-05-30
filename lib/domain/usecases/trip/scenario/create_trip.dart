import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class CreateTripUseCase {
  final TripRepository _repository;
  String? _thumbnail;

  CreateTripUseCase(this._repository);

  Future<Result<void>> call({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    XFile? thumbnailFile,
  }) async {
    _thumbnail = null;
    final tasks = <Future<Result<void>> Function()>[
      () => _validation(
        tripName: tripName,
        startDate: startDate,
        endDate: endDate,
      ),
      () => _handleImage(thumbnailFile),
      () => _insertData(
        tripName: tripName,
        startDate: startDate,
        endDate: endDate,
        thumbnail: _thumbnail,
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

  Future<Result<void>> _handleImage(XFile? thumbnailFile) async {
    try {
      if (thumbnailFile != null) {
        final file = File(thumbnailFile!.path);
        _thumbnail = await _repository.saveThumbnail(file);
      }
    } catch (error) {
      return Left(Failure(message: 'saving image fails'));
    }
    return Right(null);
  }

  Future<Result<void>> _insertData({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    String? thumbnail,
  }) async {
    try {
      await _repository.createTrip(
        tripName: tripName,
        startDate: startDate,
        endDate: endDate,
        thumbnail: thumbnail,
      );
    } catch (error) {
      return Left(Failure(message: 'inserting data in db fails'));
    }
    return Right(null);
  }
}
