part of 'edit_trip_bloc.dart';

@CopyWith()
class EditTripData {
  final TripEntity trip;
  final List<HistoryEntity> histories;

  const EditTripData({required this.trip, required this.histories});
}

@CopyWith()
class EditTripState extends AbsBlocState<EditTripData> {
  EditTripState({super.status, super.message, required super.data});

  factory EditTripState.initialState(TripEntity initialTrip) {
    return EditTripState(
      status: Status.initial,
      message: '',
      data: EditTripData(trip: initialTrip, histories: []),
    );
  }
}
