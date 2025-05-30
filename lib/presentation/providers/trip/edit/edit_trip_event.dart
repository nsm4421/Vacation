part of 'edit_trip_bloc.dart';

abstract class EditTripEvent {}

class MountEditTripEvent extends EditTripEvent {}

class UpdateStateEvent extends EditTripEvent {
  final Status? status;
  final String? message;

  UpdateStateEvent({this.status, this.message});
}

class UpdateTripDataEvent extends EditTripEvent {
  final String? tripName;
  final DateTimeRange? dateRange;

  UpdateTripDataEvent({this.tripName, this.dateRange});
}

class UpdateHistoryDataEvent extends EditTripEvent {
  final int historyId;
  final String? placeName;
  final String? description;
  final DateTime? visitedAt;

  UpdateHistoryDataEvent({
    required this.historyId,
    this.placeName,
    this.description,
    this.visitedAt,
  });
}

class InsertHistoryDataEvent extends EditTripEvent {
  final String placeName;
  final String description;
  final DateTime visitedAt;
  final double? latitude;
  final double? longitude;

  InsertHistoryDataEvent({
    required this.placeName,
    required this.description,
    required this.visitedAt,
    required this.latitude,
    required this.longitude,
  });
}

class DeleteHistoryEvent extends EditTripEvent {
  final int historyId;

  DeleteHistoryEvent(this.historyId);
}
