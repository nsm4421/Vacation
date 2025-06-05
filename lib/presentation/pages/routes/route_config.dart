import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:go_router/go_router.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/pages/export.dart';
import 'package:vacation/shared/export.dart';

import '../trip/detail/s_trip_detail.dart';
import '../trip/edit/s_edit_trip.dart';

part 'route_paths.dart';

@lazySingleton
class CustomRouter with LoggerMixIn {
  late final GlobalKey<NavigatorState> _rootNavigatorKey;

  CustomRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  }

  @lazySingleton
  GoRouter get routerConfig => GoRouter(
    initialLocation: RoutePaths.displayTrips.path,
    navigatorKey: _rootNavigatorKey,
    routes: _tripRoutes.toList(),
  );

  @lazySingleton
  Iterable<GoRoute> get _tripRoutes => [
    GoRoute(
      path: RoutePaths.displayTrips.path,
      builder: (_, __) => const DisplayTripScreen(),
    ),
    GoRoute(
      path: RoutePaths.createTrip.path,
      builder: (_, __) => const CreateTripScreen(),
    ),
    GoRoute(
      path: RoutePaths.tripDetail.path,
      builder: (_, state) {
        try {
          final e = state.extra as TripEntity;
          return TripDetailScreen(e);
        } catch (error) {
          logger.e(error);
          return Text('PAGE NOT FOUND');
        }
      },
    ),
    GoRoute(
      path: RoutePaths.editTrip.path,
      builder: (_, state) {
        try {
          final e = state.extra as TripEntity;
          return EditTripScreen(e);
        } catch (error) {
          logger.e(error);
          return Text('PAGE NOT FOUND');
        }
      },
    ),
  ];
}
