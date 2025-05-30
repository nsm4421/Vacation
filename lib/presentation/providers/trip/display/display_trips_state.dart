part of 'display_trips_bloc.dart';

@CopyWith()
class DisplayTripsState extends AbsBlocState<List<TripEntity>> {
  DisplayTripsState({super.status, super.message, required super.data});

  factory DisplayTripsState.initState() {
    return DisplayTripsState(data: []);
  }
}
