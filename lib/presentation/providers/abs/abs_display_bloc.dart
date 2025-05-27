import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vacation/shared/export.dart';
import 'package:vacation/domain/entities/export.dart';

import 'abs_state.dart';

part 'abs_display_state.dart';

part 'abs_display_event.dart';

abstract class AbsDisplayBloc<T extends BaseEntity>
    extends Bloc<AbsDisplayEvent, AbsDisplayState<T>>
    with LoggerMixIn {
  AbsDisplayBloc() : super(AbsDisplayState<T>.initState()) {
    on<InitDisplayEvent>(onInit);
    on<MountDisplayEvent>(onMount);
    on<RefreshDisplayEvent>(onRefresh);
    on<FetchDisplayEvent>(onFetch);
  }

  Future<void> onInit(
    InitDisplayEvent event,
    Emitter<AbsDisplayState<T>> emit,
  ) async {
    try {
      emit(state.copyWith(status: event.status, message: event.message));
    } catch (error) {
      logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          message: 'init display state fails',
        ),
      );
    }
  }

  Future<Either<Failure, List<T>>> handleMountEvent(MountDisplayEvent event);

  Future<Either<Failure, List<T>>> handleRefreshEvent(
    RefreshDisplayEvent event,
  );

  Future<Either<Failure, List<T>>> handleFetchEvent(FetchDisplayEvent event);

  Future<void> onMount(
    MountDisplayEvent event,
    Emitter<AbsDisplayState<T>> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading, data: [], message: ''));
      await handleMountEvent(event).then(
        (res) => res.fold(
          (l) {
            logger.e(l.message);
            emit(state.copyWith(status: Status.error, message: l.message));
          },
          (r) {
            final data = (event.reverse ? r.reversed : r);
            emit(
              state.copyWith(
                status: Status.success,
                data: data.toList(),
                message: '',
                isEnd: data.length < event.limit,
              ),
            );
          },
        ),
      );
    } catch (error) {
      logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          message: 'init display state fails',
        ),
      );
    }
  }

  Future<void> onRefresh(
    RefreshDisplayEvent event,
    Emitter<AbsDisplayState<T>> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading, data: [], message: ''));
      await handleRefreshEvent(event).then(
        (res) => res.fold(
          (l) {
            logger.d(l.message);
            emit(state.copyWith(status: Status.error, message: l.message));
          },
          (r) {
            final data = (event.reverse ? r.reversed : r);
            emit(
              state.copyWith(
                status: Status.success,
                data: data.toList(),
                message: '',
                isEnd: data.length < event.limit,
              ),
            );
          },
        ),
      );
    } catch (error) {
      logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          message: 'refresh display state fails',
        ),
      );
    }
  }

  Future<void> onFetch(
    FetchDisplayEvent event,
    Emitter<AbsDisplayState<T>> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await handleFetchEvent(event).then(
        (res) => res.fold(
          (l) {
            logger.d(l.message);
            emit(state.copyWith(status: Status.error, message: l.message));
          },
          (r) {
            final data = (event.reverse ? r.reversed : r);
            emit(
              state.copyWith(
                status: Status.success,
                data:
                    event.insertOnHead
                        ? [...data, ...state.data]
                        : [...state.data, ...data],
                message: '',
                isEnd: data.length < event.limit,
              ),
            );
          },
        ),
      );
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'fetching fails'));
    }
  }
}
