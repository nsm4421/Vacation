import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vacation/domain/usecases/export.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/shared/export.dart';

import '../../abs/abs_state.dart';

part 'display_trips_event.dart';

part 'display_trips_state.dart';

part 'display_trips_bloc.g.dart';

@injectable
class DisplayTripsBloc extends Bloc<DisplayTripsEvent, DisplayTripsState>
    with LoggerMixIn {
  final TripUseCase _useCase;

  DisplayTripsBloc(this._useCase) : super(DisplayTripsState.initState()) {
    on<UpdateDisplayTripsStateEvent>(_onUpdate);
    on<DisplayTripsMountedEvent>(_onMount);
    on<DeleteTripEvent>(_onDelete);
  }

  Future<void> _onUpdate(
    UpdateDisplayTripsStateEvent event,
    Emitter<DisplayTripsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: event.status ?? state.status,
        message: event.message ?? state.message,
      ),
    );
  }

  Future<void> _onMount(
    DisplayTripsMountedEvent event,
    Emitter<DisplayTripsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase.fetchAllTrips().then(
        (res) => res.fold(
          (l) {
            logger.e(l);
            emit(
              state.copyWith(
                status: Status.error,
                message: l.message ?? 'fetching trip fails',
              ),
            );
          },
          (r) {
            emit(state.copyWith(status: Status.success, message: '', data: r));
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

  Future<void> _onDelete(
    DeleteTripEvent event,
    Emitter<DisplayTripsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .deleteTrip(event.id)
          .then(
            (res) => res.fold(
              (l) {
                logger.e(l);
                emit(
                  state.copyWith(
                    status: Status.error,
                    message: l.message ?? 'delete trip fails',
                  ),
                );
              },
              (r) {
                logger.t('id ${event.id} deleted successfully');
                emit(
                  state.copyWith(
                    status: Status.success,
                    message: '',
                    data: state.data.where((e) => e.id != event.id).toList(),
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
          message: 'delete trip fails',
        ),
      );
    }
  }
}
