import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:vacation/data/datasources/export.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/repositories/export.dart';

@LazySingleton(as: TripRepository)
class TripRepositoryImpl implements TripRepository {
  final LocalTripDataSource _localDataSource;
  final LocalStorage _localStorage;

  TripRepositoryImpl({
    required LocalTripDataSource localDataSource,
    required LocalStorage localStorage,
  }) : _localDataSource = localDataSource,
       _localStorage = localStorage;

  /// database
  @override
  Future<int> createTrip({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    String? thumbnail,
  }) async {
    return await _localDataSource.insertTrip(
      tripName: tripName,
      startDate: startDate,
      endDate: endDate,
      thumbnail: thumbnail,
    );
  }

  @override
  Future<List<TripEntity>> fetchAllTrips() async {
    return await _localDataSource.fetchAllTrips().then(
      (res) => res.map(TripEntity.from).toList(),
    );
  }

  @override
  Future<bool> updateTrip({
    required int id,
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
    String? thumbnail,
  }) async {
    return await _localDataSource.updateTrip(
      id: id,
      tripName: tripName,
      startDate: startDate,
      endDate: endDate,
      thumbnail: thumbnail,
    );
  }

  @override
  Future<int> deleteTripById(int id) async {
    return await _localDataSource.deleteTripById(id);
  }

  /// local storage
  @override
  Future<String> changeThumbnail({
    required File file,
    required String originalPath,
  }) async {
    return await _localStorage.saveFileAndReturnPath(file: file, upsert: true);
  }

  @override
  Future<void> deleteThumbnail(String path) async {
    return await _localStorage.deleteFile(path);
  }

  @override
  Future<String> saveThumbnail(File file) async {
    return await _localStorage.saveFileAndReturnPath(file: file, upsert: false);
  }
}
