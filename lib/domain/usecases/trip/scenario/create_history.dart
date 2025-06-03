import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class CreateHistoryUseCase {
  final HistoryRepository _repository;
  List<String> _images = [];
  HistoryEntity? _history;

  CreateHistoryUseCase(this._repository);

  Future<Result<HistoryEntity?>> call({
    required int tripId,
    required String placeName,
    required String description,
    required List<XFile> images,
    required DateTime visitedAt,
    double? latitude,
    double? longitude,
  }) async {
    _images = [];
    _history = null;
    final tasks = <Future<Result<HistoryEntity?>> Function()>[
      () => _validation(placeName: placeName, visitedAt: visitedAt),
      () => _handleImage(images),
      () => _insertData(
        tripId: tripId,
        placeName: placeName,
        description: description,
        images: _images,
        visitedAt: visitedAt,
        latitude: latitude,
        longitude: longitude,
      ),
    ];

    for (final task in tasks) {
      final result = await task();
      if (result.isLeft) return result;
    }

    return Right(_history);
  }

  Future<Result<HistoryEntity?>> _validation({
    required String placeName,
    required DateTime visitedAt,
  }) async {
    if (placeName.isEmpty) {
      return Left(Failure(message: "place name is not given"));
    } else if (visitedAt.isAfter(DateTime.now())) {
      return Left(Failure(message: "visited at can't be after than today"));
    }
    return Right(null);
  }

  Future<Result<HistoryEntity?>> _handleImage(List<XFile> images) async {
    try {
      if (images.isNotEmpty) {
        final futures = images.map((image) async {
          final file = File(image.path);
          return await _repository.saveImage(file);
        });
        _images = await Future.wait(futures); // 이미지 경로 업데이트
      }
    } catch (error) {
      return Left(Failure(message: 'saving image fails'));
    }
    return Right(null);
  }

  Future<Result<HistoryEntity?>> _insertData({
    required int tripId,
    required String placeName,
    required String description,
    required List<String> images,
    required DateTime visitedAt,
    double? latitude,
    double? longitude,
  }) async {
    try {
      return await _repository
          .createHistory(
            tripId: tripId,
            placeName: placeName,
            description: description,
            images: images,
            visitedAt: visitedAt,
            latitude: latitude,
            longitude: longitude,
          )
          .then((e) {
            _history = e; // return값 업데이트
          })
          .then(Right.new);
    } catch (error) {
      return Left(Failure(message: 'inserting data in db fails'));
    }
  }
}
