part of 'search_video.bloc.dart';

abstract class SearchVideoEvent {}

class ResetVideoEvent extends SearchVideoEvent {}

class FetchMoreVideoEvent extends SearchVideoEvent {}

class KeywordChangedEvent extends SearchVideoEvent {
  final String query;

  KeywordChangedEvent(this.query);
}

class UpdateSearchVideoStateEvent extends SearchVideoEvent {
  final Status? status;
  final String? message;

  UpdateSearchVideoStateEvent({this.status, this.message});
}
