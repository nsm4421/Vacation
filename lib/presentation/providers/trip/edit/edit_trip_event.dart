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
  final XFile? thumbnail;

  UpdateTripDataEvent({this.tripName, this.dateRange, this.thumbnail});
}

class UpdateHistoryDataEvent extends EditTripEvent {
  final int historyId;
  final String? placeName;
  final String? description;
  final DateTime? visitedAt;
  final List<XFile>? images;

  UpdateHistoryDataEvent({
    required this.historyId,
    this.placeName,
    this.description,
    this.visitedAt,
    this.images,
  });
}

class InsertHistoryDataEvent extends EditTripEvent {
  final String placeName;
  final String description;
  final DateTime visitedAt;
  final double? latitude;
  final double? longitude;
  final List<XFile> images;

  InsertHistoryDataEvent({
    required this.placeName,
    required this.description,
    required this.visitedAt,
    required this.latitude,
    required this.longitude,
    required this.images,
  });
}

class DeleteHistoryEvent extends EditTripEvent {
  final int historyId;

  DeleteHistoryEvent(this.historyId);
}
