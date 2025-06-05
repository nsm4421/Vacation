import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/usecases/export.dart';
import 'package:vacation/shared/export.dart';
import '../../abs/abs_state.dart';

part 'edit_trip_event.dart';

part 'edit_trip_state.dart';

part 'edit_trip_bloc.g.dart';

@injectable
class EditTripBloc extends Bloc<EditTripEvent, EditTripState> with LoggerMixIn {
  final TripEntity _initialTrip;
  final TripUseCase _tripUseCase;
  final HistoryUseCase _historyUseCase;

  TripEntity get initialTrip => _initialTrip;

  EditTripBloc(
    @factoryParam this._initialTrip, {
    required TripUseCase tripUseCase,
    required HistoryUseCase historyUseCase,
  }) : _tripUseCase = tripUseCase,
       _historyUseCase = historyUseCase,
       super(EditTripState.initialState(_initialTrip)) {
    on<UpdateStateEvent>(_onUpdateState);
    on<UpdateTripDataEvent>(_onUpdateTrip);
    on<UpdateHistoryDataEvent>(_onUpdateHistory);
    on<InsertHistoryDataEvent>(_onInsertHistory);
    on<DeleteHistoryEvent>(_onDeleteHistory);
    on<MountEditTripEvent>(_onMount);
  }

  Future<void> _onUpdateState(
    UpdateStateEvent event,
    Emitter<EditTripState> emit,
  ) async {
    emit(
      state.copyWith(
        status: event.status ?? state.status,
        message: event.message ?? state.message,
      ),
    );
  }

  Future<void> _onUpdateTrip(
    UpdateTripDataEvent event,
    Emitter<EditTripState> emit,
  ) async {
    try {
      var temp = initialTrip;
      temp = temp.copyWith(
        tripName: event.tripName ?? state.data.trip.tripName,
        startDate: event.dateRange?.start ?? state.data.trip.startDate,
        endDate: event.dateRange?.end ?? state.data.trip.endDate,
      );
      await _tripUseCase
          .editTrip(
            id: temp.id,
            tripName: temp.tripName,
            startDate: temp.startDate,
            endDate: temp.endDate,
            thumbnailFile: event.thumbnail,
          )
          .then(
            (res) => res.fold(
              (l) {
                emit(
                  state.copyWith(
                    status: Status.error,
                    message: l.message ?? 'updating travel fails',
                  ),
                );
              },
              (r) {
                emit(
                  state.copyWith(
                    status: Status.success,
                    data: state.data.copyWith(
                      trip: temp.copyWith(thumbnail: r), // 썸네일 파일 경로 업데이트
                    ),
                  ),
                );
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      emit(
        state.copyWith(status: Status.error, message: 'updating history fails'),
      );
    }
  }

  Future<void> _onUpdateHistory(
    UpdateHistoryDataEvent event,
    Emitter<EditTripState> emit,
  ) async {
    try {
      await _historyUseCase
          .editHistory(
            historyId: event.historyId,
            placeName: event.placeName,
            description: event.description,
            visitedAt: event.visitedAt,
            images: event.images,
          )
          .then(
            (res) => res.fold(
              (l) {
                emit(
                  state.copyWith(
                    status: Status.error,
                    message: l.message ?? 'updating history fails',
                  ),
                );
              },
              (r) {
                if (r == null) {
                  logger.w('updated result not given');
                }
                emit(
                  state.copyWith(
                    status: Status.success,
                    data: state.data.copyWith(
                      histories:
                          state.data.histories
                              .map(
                                (e) => e.id == event.historyId ? (r ?? e) : e,
                              )
                              .toList(),
                    ),
                  ),
                );
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      emit(
        state.copyWith(status: Status.error, message: 'updating history fails'),
      );
    }
  }

  Future<void> _onInsertHistory(
    InsertHistoryDataEvent event,
    Emitter<EditTripState> emit,
  ) async {
    try {
      await _historyUseCase
          .createHistory(
            tripId: _initialTrip.id,
            placeName: event.placeName,
            description: event.description,
            visitedAt: event.visitedAt,
            latitude: event.latitude,
            longitude: event.longitude,
            images: event.images,
          )
          .then(
            (res) => res.fold(
              (l) {
                emit(
                  state.copyWith(
                    status: Status.error,
                    message: l.message ?? 'inserting history fails',
                  ),
                );
              },
              (r) {
                if (r == null) {
                  logger.w('created history not returned');
                } else {
                  logger.t('history inserted');
                }
                emit(
                  state.copyWith(
                    status: Status.success,
                    data: state.data.copyWith(
                      histories:
                          r == null
                              ? state.data.histories
                              : [...state.data.histories, r],
                    ),
                  ),
                );
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      emit(
        state.copyWith(status: Status.error, message: 'updating history fails'),
      );
    }
  }

  Future<void> _onDeleteHistory(
    DeleteHistoryEvent event,
    Emitter<EditTripState> emit,
  ) async {
    try {
      await _historyUseCase
          .deleteHistory(event.historyId)
          .then(
            (res) => res.fold(
              (l) {
                emit(
                  state.copyWith(
                    status: Status.error,
                    message: l.message ?? 'delete history fails',
                  ),
                );
              },
              (r) {
                logger.t('history deleted');
                emit(
                  state.copyWith(
                    status: Status.success,
                    data: state.data.copyWith(
                      histories:
                          state.data.histories
                              .where((e) => e.id != event.historyId)
                              .toList(),
                    ),
                  ),
                );
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      emit(
        state.copyWith(status: Status.error, message: 'delete history fails'),
      );
    }
  }

  Future<void> _onMount(
    MountEditTripEvent event,
    Emitter<EditTripState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading, message: ''));
      await _historyUseCase
          .fetchAllHistoriesByTripId(_initialTrip.id)
          .then(
            (res) => res.fold(
              (l) {
                logger.e(l);
                emit(
                  state.copyWith(
                    status: Status.error,
                    message: l.message ?? 'mounting fails',
                  ),
                );
              },
              (r) {
                logger.t('fetching success');
                emit(
                  state.copyWith(
                    status: Status.success,
                    message: '',
                    data: state.data.copyWith(histories: r),
                  ),
                );
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(status: Status.error, message: 'mounting fails'));
    }
  }
}
