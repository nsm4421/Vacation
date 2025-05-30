import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_trip.freezed.dart';

part 'fetch_trip.g.dart';

@freezed
@JsonSerializable()
class FetchTripModel with _$FetchTripModel {
  FetchTripModel({
    required this.id,
    required this.tripName,
    required this.startDate,
    required this.endDate,
    this.thumbnail
  });

  final int id;
  final String tripName;
  final DateTime startDate;
  final DateTime endDate;
  final String? thumbnail;

  factory FetchTripModel.fromJson(Map<String, dynamic> json) =>
      _$FetchTripModelFromJson(json);
}
