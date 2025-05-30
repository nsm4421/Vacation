import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class EditTripUseCase {
  final TripRepository _repository;
  String? _thumbnail;

  EditTripUseCase(this._repository);

  Future<Result<void>> call({
    required int id,
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    XFile? thumbnailFile,
    String? originalThumbnail,
  }) async {
    _thumbnail = null;
    final tasks = <Future<Result<void>> Function()>[
      () => _validation(
        tripName: tripName,
        startDate: startDate,
        endDate: endDate,
      ),
      () => _handleThumbnail(
        thumbnailFile: thumbnailFile,
        originalThumbnail: originalThumbnail,
      ),
      () => _updateData(
        id: id,
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

  Future<Result<void>> _handleThumbnail({
    String? originalThumbnail,
    XFile? thumbnailFile,
  }) async {
    try {
      if (originalThumbnail == null && thumbnailFile != null) {
        _thumbnail = await _repository.saveThumbnail(File(thumbnailFile.path));
      } else if (originalThumbnail != null && thumbnailFile == null) {
        await _repository.deleteThumbnail(originalThumbnail);
      } else if (originalThumbnail != null && thumbnailFile != null) {
        _thumbnail = await _repository.changeThumbnail(
          file: File(thumbnailFile.path),
          originalPath: originalThumbnail,
        );
      }
      return Right(null);
    } catch (error) {
      return Left(Failure(message: 'modifying trip fails'));
    }
  }

  Future<Result<void>> _updateData({
    required int id,
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    String? thumbnail,
  }) async {
    try {
      await _repository.updateTrip(
        id: id,
        tripName: tripName,
        startDate: startDate,
        endDate: endDate,
        thumbnail: thumbnail,
      );
    } catch (error) {
      return Left(Failure(message: 'modifying trip fails'));
    }
    return Right(null);
  }
}
