import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:vacation/domain/usecases/export.dart';
import 'package:vacation/shared/export.dart';

import '../../abs/abs_state.dart';

part 'create_trip_cubit.g.dart';

part 'create_trip_state.dart';

@injectable
class CreateTripCubit extends Cubit<CreateTripState> with LoggerMixIn {
  final TripUseCase _useCase;

  CreateTripCubit(this._useCase) : super(CreateTripState.initState());

  void updateStatus({Status? status, String? message}) {
    emit(
      state.copyWith(
        status: status ?? state.status,
        message: message ?? state.message,
      ),
    );
  }

  void updateData({String? tripName, DateTimeRange? dateRange}) {
    emit(
      state.copyWith(
        data: state.data.copyWith(
          tripName: tripName ?? state.data.tripName,
          dateRange: dateRange ?? state.data.dateRange,
        ),
      ),
    );
  }

  void selectThumbnail(XFile thumbnail) {
    emit(state.copyWith(data: state.data.copyWith(thumbnail: thumbnail)));
  }

  void unSelectThumbnail() {
    emit(state.copyWith(data: state.data.copyWithNull(thumbnail: true)));
  }

  Future<void> submit() async {
    try {
      await _useCase
          .createTrip(
            tripName: state.data.tripName,
            startDate: state.data.dateRange.start,
            endDate: state.data.dateRange.end,
            thumbnailFile: state.data.thumbnail,
          )
          .then(
            (res) => res.fold(
              (l) {
                updateStatus(status: Status.error, message: l.message);
                logger.e(l.message);
              },
              (r) {
                updateStatus(status: Status.success, message: '');
                logger.t('success');
              },
            ),
          );
    } catch (error) {
      logger.e(error);
    }
  }
}
