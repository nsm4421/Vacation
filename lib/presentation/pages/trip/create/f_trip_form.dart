import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/presentation/widgets/export.dart';

import 'w_select_image.dart';

class TripFormFragment extends StatelessWidget {
  const TripFormFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TripFormWidget(
          initialTripName: '',
          initialDateRange: DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(Duration(days: 7)),
          ),
          handleUpdateTripName: (tripName) {
            context.read<CreateTripCubit>().updateData(tripName: tripName);
          },
          handleUpdateDateRange: (dateRange) {
            context.read<CreateTripCubit>().updateData(dateRange: dateRange);
          },
        ),
        SizedBox(height: 12),
        SelectImageWidget(),
      ],
    );
  }
}
