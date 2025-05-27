import 'package:injectable/injectable.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'scenario/create_trip.dart';
import 'scenario/delete_trip.dart';
import 'scenario/edit_trip.dart';
import 'scenario/fetch_all_trips.dart';

@lazySingleton
class TripUseCase {
  final TripRepository _repository;

  TripUseCase(this._repository);

  @lazySingleton
  CreateTripUseCase get createTrip => CreateTripUseCase(_repository);

  @lazySingleton
  FetchAllTripsUseCase get fetchAllTrips => FetchAllTripsUseCase(_repository);

  @lazySingleton
  EditTripUseCase get editTrip => EditTripUseCase(_repository);

  @lazySingleton
  DeleteTripUseCase get deleteTrip => DeleteTripUseCase(_repository);
}
