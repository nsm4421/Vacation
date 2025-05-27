import 'package:injectable/injectable.dart';
import 'package:vacation/data/datasources/export.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/repositories/export.dart';

@LazySingleton(as: TripRepository)
class TripRepositoryImpl implements TripRepository {
  final LocalTripDataSource _localDataSource;

  TripRepositoryImpl(this._localDataSource);

  @override
  Future<int> createTrip({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return await _localDataSource.insertTrip(
      tripName: tripName,
      startDate: startDate,
      endDate: endDate,
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
  }) async {
    return await _localDataSource.updateTrip(
      id: id,
      tripName: tripName,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<int> deleteTripById(int id) async {
    return await _localDataSource.deleteTripById(id);
  }
}
