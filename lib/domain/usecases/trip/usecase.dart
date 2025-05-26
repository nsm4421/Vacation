import 'package:injectable/injectable.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'scenario/create_trip.dart';

@lazySingleton
class TripUseCase {
  final TripRepository _repository;

  TripUseCase(this._repository);

  @lazySingleton
  CreateTripUseCase get createTrip => CreateTripUseCase(_repository);
}
