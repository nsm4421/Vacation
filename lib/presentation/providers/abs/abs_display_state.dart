part of 'abs_display_bloc.dart';

class AbsDisplayState<T extends BaseEntity> extends AbsBlocState<List<T>> {
  final bool isEnd;

  AbsDisplayState({
    super.status,
    super.message,
    required super.data,
    this.isEnd = false,
  });

  factory AbsDisplayState.initState() => AbsDisplayState<T>(
    status: Status.initial,
    message: '',
    data: <T>[],
    isEnd: false,
  );

  AbsDisplayState<T> copyWith({
    Status? status,
    String? message,
    List<T>? data,
    bool? isEnd,
  }) => AbsDisplayState<T>(
    status: status ?? this.status,
    message: message ?? this.message,
    data: data ?? this.data,
    isEnd: isEnd ?? this.isEnd,
  );
}
