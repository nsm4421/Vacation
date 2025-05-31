import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacation/dependency_injection.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/presentation/widgets/export.dart';
import 'package:vacation/shared/export.dart';

import 'f_trip_info.dart';
import 'f_histories.dart';

class EditTripScreen extends StatelessWidget {
  const EditTripScreen(this._trip, {super.key});

  final TripEntity _trip;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => getIt<EditTripBloc>(param1: _trip)..add(MountEditTripEvent()),
      child: BlocListener<EditTripBloc, EditTripState>(
        listenWhen:
            (prev, curr) =>
                (curr.status == Status.success) ||
                (curr.status == Status.error),
        listener: (context, state) {
          if (state.status == Status.error) {
            context.showErrorSnackBar(state.message);
          }
          Timer(Duration(seconds: 1), () {
            if (context.mounted) {
              context.read<EditTripBloc>().add(
                UpdateStateEvent(status: Status.initial, message: ''),
              );
            }
          });
        },
        child: BlocBuilder<EditTripBloc, EditTripState>(
          builder: (context, state) {
            return LoadingOverlayWidget(
              showOverlay: state.status == Status.loading,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Edit Trip'),
                  actions: [
                    CircularAvatarImageWidget(
                      imagePath: state.data.trip.thumbnail,
                    ),
                  ],
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: TripInfoFragment(state.data.trip),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: HistoriesFragment(state.data.histories),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
