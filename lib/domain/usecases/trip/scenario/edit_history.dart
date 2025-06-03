import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class EditHistoryDataUseCase {
  final HistoryRepository _repository;
  final Logger? _logger;
  List<String> _images = [];
  HistoryEntity? _history;

  EditHistoryDataUseCase(this._repository, {Logger? logger}) : _logger = logger;

  Future<Result<HistoryEntity?>> call({
    required int historyId,
    String? placeName,
    String? description,
    List<XFile>? images,
    List<String>? originalImages,
    DateTime? visitedAt,
  }) async {
    _images = [];
    _history = null;
    final tasks = <Future<Result<HistoryEntity?>> Function()>[
      () => _validation(placeName: placeName, visitedAt: visitedAt),
      () => _handleImage(originalImages: originalImages, images: images),
      () => _updateData(
        historyId: historyId,
        placeName: placeName,
        description: description,
        images: _images,
        visitedAt: visitedAt,
      ),
    ];
    for (final task in tasks) {
      final result = await task();
      if (result.isLeft) return result;
    }

    return Right(_history);
  }

  Future<Result<HistoryEntity?>> _validation({
    String? placeName,
    DateTime? visitedAt,
  }) async {
    if (placeName != null && placeName.isEmpty) {
      return Left(Failure(message: "place name is not given"));
    } else if (visitedAt != null && visitedAt.isAfter(DateTime.now())) {
      return Left(Failure(message: "visited at can't be after than today"));
    }
    return Right(null);
  }

  Future<Result<HistoryEntity?>> _handleImage({
    List<XFile>? images,
    List<String>? originalImages,
  }) async {
    // 이미지 저장
    try {
      if (images != null && images.isNotEmpty) {
        _images = await Future.wait(
          images.map((e) async {
            final file = File(e.path);
            return await _repository.saveImage(file);
          }),
        );
      }
    } catch (error) {
      return Left(Failure(message: 'modifying image fails'));
    }
    // 기존 이미지 삭제
    try {
      if (originalImages != null && originalImages.isNotEmpty) {
        await Future.wait(
          originalImages.map((path) async {
            await _repository.deleteImage(path);
          }),
        );
      }
    } catch (error) {
      _logger?.w('deleting previous image fails');
    }
    return Right(null);
  }

  Future<Result<HistoryEntity?>> _updateData({
    required int historyId,
    String? placeName,
    String? description,
    List<String>? images,
    DateTime? visitedAt,
  }) async {
    try {
      _history = await _repository.updateHistory(
        historyId: historyId,
        placeName: placeName,
        description: description,
        images: images,
        visitedAt: visitedAt,
      );
    } catch (error) {
      return Left(Failure(message: 'updating data in db fails'));
    }
    return Right(_history);
  }
}
