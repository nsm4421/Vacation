import 'package:copy_with_extension/copy_with_extension.dart';

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
}
