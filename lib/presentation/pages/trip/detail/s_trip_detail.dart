import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacation/dependency_injection.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/presentation/widgets/export.dart';
import 'package:vacation/shared/export.dart';

import 'f_histories.dart';

class TripDetailScreen extends StatelessWidget {
  const TripDetailScreen(this._trip, {super.key});

  final TripEntity _trip;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DisplayTripDetailCubit>(param1: _trip)..mount(),
      child: BlocBuilder<DisplayTripDetailCubit, DisplayTripDetailState>(
        builder: (context, state) {
          return LoadingOverlayWidget(
            showOverlay: state.status == Status.loading,
            child: Scaffold(
              appBar: AppBar(),
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      child: TripInfoWidget(_trip),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        child: HistoriesFragment(state.data),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
