part of 'datasource_impl.dart';

abstract interface class LocalTripDataSource {
  Future<int> insertTripAndReturnId({
    required String tripName,
    required DateTime startDate,
    required DateTime endDate,
  });
}
