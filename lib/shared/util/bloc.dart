enum Status { initial, loading, error, success }

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
