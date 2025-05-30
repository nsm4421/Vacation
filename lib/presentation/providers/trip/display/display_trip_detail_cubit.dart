import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/usecases/export.dart';
import 'package:vacation/shared/export.dart';
import '../../abs/abs_state.dart';

part 'display_trip_detail_state.dart';

@injectable
class DisplayTripDetailCubit extends Cubit<DisplayTripDetailState>
    with LoggerMixIn {
  final TripEntity _trip;
  final HistoryUseCase _useCase;

  TripEntity get trip => _trip;

  DisplayTripDetailCubit({
    @factoryParam required TripEntity trip,
    required HistoryUseCase useCase,
  }) : _trip = trip,
       _useCase = useCase,
       super(DisplayTripDetailState.initState(trip));

  Future<void> mount() async {
    try {
      emit(state.copyWith(status: Status.loading));
      await _useCase
          .fetchAllHistoriesByTripId(_trip.id)
          .then(
            (res) => res.fold(
              (l) {
                logger.e(l.message);
                emit(state.copyWith(status: Status.error, message: l.message));
              },
              (r) {
                emit(state.copyWith(status: Status.success, histories: r));
              },
            ),
          );
    } catch (error) {
      logger.e(error);
      emit(
        state.copyWith(
          status: Status.error,
          message: 'fetching histories fails',
        ),
      );
    }
  }
}
