part of 'display_trip_detail_cubit.dart';

class DisplayTripDetailState extends AbsBlocState<List<HistoryEntity>> {

  DisplayTripDetailState({
    super.status,
    super.message,
    required List<HistoryEntity> histories,
  }) : super(data: histories);

  factory DisplayTripDetailState.initState(TripEntity trip) {
    return DisplayTripDetailState(histories: []);
  }

  DisplayTripDetailState copyWith({
    Status? status,
    String? message,
    List<HistoryEntity>? histories,
  }) {
    return DisplayTripDetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      histories: histories ?? data,
    );
  }
}
