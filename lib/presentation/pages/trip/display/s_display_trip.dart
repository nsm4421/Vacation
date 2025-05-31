import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vacation/dependency_injection.dart';
import 'package:vacation/presentation/pages/export.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/presentation/widgets/export.dart';
import 'package:vacation/shared/export.dart';

import 'f_trip_items.dart';

class DisplayTripScreen extends StatelessWidget {
  const DisplayTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DisplayTripsBloc>()..add(DisplayTripsMountedEvent()),
      child: BlocListener<DisplayTripsBloc, DisplayTripsState>(
        listenWhen: (prev, curr) => curr.status == Status.error,
        listener: (context, state) {
          context
            ..showErrorSnackBar(state.message)
            ..read<DisplayTripsBloc>().add(
              UpdateDisplayTripsStateEvent(status: Status.initial),
            );
        },
        child: BlocBuilder<DisplayTripsBloc, DisplayTripsState>(
          builder: (context, state) {
            return LoadingOverlayWidget(
              showOverlay: (state.status == Status.loading),
              child: Scaffold(
                appBar: AppBar(
                  title: Text("My Trips"),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        await context.push(
                          RoutePaths.createTrip.path,
                        ); // 여행계획 생성페이지로 이동
                      },
                      icon: Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                body: TripItemsFragment(state.data),
              ),
            );
          },
        ),
      ),
    );
  }
}
