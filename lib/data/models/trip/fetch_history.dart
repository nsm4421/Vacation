import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vacation/data/datasources/export.dart';

part 'fetch_history.freezed.dart';

part 'fetch_history.g.dart';

@freezed
@JsonSerializable()
class FetchHistoryModel with _$FetchHistoryModel {
  FetchHistoryModel({
    required this.id,
    required this.tripId,
    required this.placeName,
    required this.description,
    required this.visitedAt,
    required this.images,
    this.latitude,
    this.longitude,
  });

  final int id;
  final int tripId;
  final String placeName;
  final String description;
  final DateTime visitedAt;
  final List<String> images;
  final double? latitude;
  final double? longitude;

  factory FetchHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$FetchHistoryModelFromJson(json);
}
