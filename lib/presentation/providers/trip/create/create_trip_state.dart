part of 'create_trip_cubit.dart';

@CopyWith(copyWithNull: true)
class CreateTripData {
  final String tripName;
  final DateTimeRange dateRange;
  final XFile? thumbnail;

  CreateTripData({this.tripName = '', required this.dateRange, this.thumbnail});
}

@CopyWith()
class CreateTripState extends AbsBlocState<CreateTripData> {
  CreateTripState({super.status, super.message, required super.data});

  factory CreateTripState.initState() => CreateTripState(
    data: CreateTripData(
      tripName: '',
      dateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 7)),
      ),
    ),
  );
}
