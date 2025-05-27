part of 'abs_display_bloc.dart';

abstract class AbsDisplayEvent {}

sealed class InitDisplayEvent extends AbsDisplayEvent {
  final Status? status;
  final String? message;

  InitDisplayEvent({this.status, this.message});
}

sealed class MountDisplayEvent extends AbsDisplayEvent {
  final int limit;
  final bool reverse;

  MountDisplayEvent({this.limit = 20, this.reverse = false});
}

sealed class RefreshDisplayEvent extends AbsDisplayEvent {
  final int limit;
  final bool reverse;

  RefreshDisplayEvent({this.limit = 20, this.reverse = false});
}

sealed class FetchDisplayEvent extends AbsDisplayEvent {
  final int limit;
  final bool insertOnHead;
  final bool reverse;

  FetchDisplayEvent({
    this.limit = 20,
    this.insertOnHead = false,
    this.reverse = false,
  });
}
