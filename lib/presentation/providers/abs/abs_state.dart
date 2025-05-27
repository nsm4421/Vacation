import 'package:vacation/shared/export.dart';

abstract class AbsBlocState<T> {
  final Status status;
  final String message;
  final T data;

  AbsBlocState({
    this.status = Status.initial,
    this.message = '',
    required this.data,
  });
}
