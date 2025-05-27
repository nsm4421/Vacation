part of 'bloc.dart';

sealed class DisplayTripsEvent {}

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
