import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:go_router/go_router.dart';
import 'package:vacation/presentation/pages/export.dart';

import '../trip/create/s_create_trip.dart';

part 'route_paths.dart';

@lazySingleton
class CustomRouter {
  late final GlobalKey<NavigatorState> _rootNavigatorKey;

  CustomRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  }

  @lazySingleton
  GoRouter get routerConfig => GoRouter(
    initialLocation: RoutePaths.entry.path,
    navigatorKey: _rootNavigatorKey,
    routes: [_indexRoute, ..._tripRoutes],
  );

  @lazySingleton
  GoRoute get _indexRoute => GoRoute(
    // 시작 페이지
    path: RoutePaths.entry.path,
    builder: (_, __) => const IndexScreen(),
  );

  @lazySingleton
  Iterable<GoRoute> get _tripRoutes => [
    GoRoute(
      path: RoutePaths.displayTrips.path,
      builder: (_, __) => const Text('NOT FOUND'),
    ),
    GoRoute(
      path: RoutePaths.createTrips.path,
      builder: (_, __) => const CreateTripScreen(),
    ),
  ];
}
