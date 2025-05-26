import 'package:injectable/injectable.dart';
import 'package:vacation/data/datasources/export.dart';
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
    return await _localDataSource.insertTripAndReturnId(
      tripName: tripName,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
