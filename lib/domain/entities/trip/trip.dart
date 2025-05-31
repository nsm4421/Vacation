import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:vacation/data/models/export.dart';

import '../base_entity.dart';

part 'trip.g.dart';

part 'history.dart';

@CopyWith(copyWithNull: true)
class TripEntity extends BaseEntity {
  final String tripName;
  final DateTime startDate;
  final DateTime endDate;
  final String? thumbnail;
  late final List<HistoryEntity> histories;

  TripEntity({
    required super.id,
    required this.tripName,
    required this.startDate,
    required this.endDate,
    this.thumbnail,
    List<HistoryEntity>? histories,
  }) {
    this.histories = histories ?? [];
  }

  DateTimeRange get dateRange => DateTimeRange(start: startDate, end: endDate);

  factory TripEntity.from(
    FetchTripModel model, {
    List<HistoryEntity>? histories,
  }) {
    return TripEntity(
      id: model.id,
      tripName: model.tripName,
      thumbnail: model.thumbnail,
      startDate: model.startDate,
      endDate: model.endDate,
      histories: histories ?? [],
    );
  }
}
