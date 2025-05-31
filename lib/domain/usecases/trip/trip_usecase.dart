import 'package:injectable/injectable.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';
import 'scenario/create_trip.dart';
import 'scenario/delete_trip.dart';
import 'scenario/edit_trip.dart';
import 'scenario/fetch_all_trips.dart';

@lazySingleton
class TripUseCase with LoggerMixIn {
  final TripRepository _repository;

  TripUseCase(this._repository);

  CreateTripUseCase get createTrip => CreateTripUseCase(_repository);

  @lazySingleton
  FetchAllTripsUseCase get fetchAllTrips => FetchAllTripsUseCase(_repository);

  EditTripUseCase get editTrip => EditTripUseCase(_repository, logger: logger);

  @lazySingleton
  DeleteTripUseCase get deleteTrip => DeleteTripUseCase(_repository);
}
