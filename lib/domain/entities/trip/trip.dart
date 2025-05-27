import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:vacation/data/models/export.dart';

import '../base_entity.dart';

part 'trip.g.dart';

part 'history.dart';

@CopyWith()
class TripEntity extends BaseEntity {
  final String tripName;
  final DateTime startDate;
  final DateTime endDate;
  late final List<HistoryEntity> histories;

  TripEntity({
    required super.id,
    required this.tripName,
    required this.startDate,
    required this.endDate,
    List<HistoryEntity>? histories,
  }) {
    this.histories = histories ?? [];
  }

  factory TripEntity.from(FetchTripModel model) {
    return TripEntity(
      id: model.id,
      tripName: model.tripName,
      startDate: model.startDate,
      endDate: model.endDate,
    );
  }
}
