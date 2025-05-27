part of 'trip.dart';

@CopyWith(copyWithNull: true)
class HistoryEntity extends BaseEntity {
  final String placeName;
  final String description;
  final DateTime visitedAt;
  final double? latitude;
  final double? longitude;

  HistoryEntity({
    required super.id,
    this.placeName = '무제',
    this.description = '',
    required this.visitedAt,
    this.latitude,
    this.longitude,
  });

  factory HistoryEntity.from(FetchHistoryModel model) {
    return HistoryEntity(
      id: model.id,
      placeName: model.placeName,
      visitedAt: model.visitedAt,
      latitude: model.latitude,
      longitude: model.longitude,
    );
  }
}
