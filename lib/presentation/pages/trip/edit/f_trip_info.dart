import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/presentation/widgets/export.dart';

import 'trip_modal/s_edit_trip_modal.dart';

class TripInfoFragment extends StatefulWidget {
  const TripInfoFragment(this._trip, {super.key});

  final TripEntity _trip;

  @override
  State<TripInfoFragment> createState() => _TripInfoFragmentState();
}

class _TripInfoFragmentState extends State<TripInfoFragment> {
  @override
  Widget build(BuildContext context) {
    return TripInfoWidget(
      widget._trip,
      onClickEditButton: () async {
        await showModalBottomSheet(
          showDragHandle: true,
          isDismissible: true,
          context: context,
          builder: (_) {
            return EditTripModalScreen(
              trip: widget._trip,
              handleCompleteEdit: ({
                required String tripName,
                required DateTimeRange dateRange,
                XFile? thumbnail,
              }) {
                context.read<EditTripBloc>().add(
                  UpdateTripDataEvent(
                    tripName: tripName,
                    dateRange: dateRange,
                    thumbnail: thumbnail,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
