part of 'cubit.dart';

@CopyWith()
class CreateTripData {
  final String tripName;
  final DateTimeRange dateRange;

  CreateTripData({this.tripName = '', required this.dateRange});
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
