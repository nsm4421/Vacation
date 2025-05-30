part of 'display_trips_bloc.dart';

abstract class DisplayTripsEvent {}

class DisplayTripsMountedEvent extends DisplayTripsEvent {}

class UpdateDisplayTripsStateEvent extends DisplayTripsEvent {
  final Status? status;
  final String? message;

  UpdateDisplayTripsStateEvent({this.status, this.message});
}

class DeleteTripEvent extends DisplayTripsEvent {
  final int id;

  DeleteTripEvent(this.id);
}
