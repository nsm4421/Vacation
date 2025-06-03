import 'package:injectable/injectable.dart';
import 'package:vacation/data/datasources/export.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/repositories/export.dart';

import '../image/image_repository_impl.dart';

@LazySingleton(as: TripRepository)
class TripRepositoryImpl extends $ImageRepositoryImpl
    implements TripRepository {
  final LocalTripDataSource _localDataSource;

  TripRepositoryImpl({
    required LocalTripDataSource localDataSource,
    required LocalStorage localStorage,
  }) : _localDataSource = localDataSource,
       super(localStorage);

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
}
