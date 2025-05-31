import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class EditTripUseCase {
  final TripRepository _repository;
  final Logger? _logger;
  String? _thumbnail;

  EditTripUseCase(this._repository, {Logger? logger}) : _logger = logger;

  Future<Result<String?>> call({
    required int id,
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    XFile? thumbnailFile,
    String? originalThumbnail,
  }) async {
    _thumbnail = null;
    final tasks = <Future<Result<String?>> Function()>[
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

    return Right(_thumbnail);
  }

  Future<Result<String?>> _validation({
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

  Future<Result<String?>> _handleThumbnail({
    String? originalThumbnail,
    XFile? thumbnailFile,
  }) async {
    try {
      if (originalThumbnail == null && thumbnailFile == null) {
        _logger?.t('thumbnail not changed');
        _thumbnail = null;
      } else if (originalThumbnail == null && thumbnailFile != null) {
        _logger?.t('thumbnail added');
        _thumbnail = await _repository.saveThumbnail(File(thumbnailFile.path));
      } else if (originalThumbnail != null && thumbnailFile == null) {
        _logger?.t('thumbnail deleted');
        await _repository.deleteThumbnail(originalThumbnail);
      } else if (originalThumbnail != null && thumbnailFile != null) {
        _logger?.t('thumbnail replaced');
        _thumbnail = await _repository.changeThumbnail(
          file: File(thumbnailFile.path),
          originalPath: originalThumbnail,
        );
      } else {
        throw Exception('impossible case');
      }
      return Right(null);
    } catch (error) {
      return Left(Failure(message: 'modifying trip fails'));
    }
  }

  Future<Result<String?>> _updateData({
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
