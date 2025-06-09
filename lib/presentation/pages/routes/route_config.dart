import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:go_router/go_router.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/pages/youtube/detail/s_video_detail.dart';
import 'package:vacation/shared/export.dart';

import '../trip/create/s_create_trip.dart';
import '../trip/detail/s_trip_detail.dart';
import '../trip/display/s_display_trip.dart';
import '../trip/edit/s_edit_trip.dart';
import '../youtube/search/s_search_videos.dart';

part 'route_paths.dart';

@lazySingleton
class CustomRouter with LoggerMixIn {
  late final GlobalKey<NavigatorState> _rootNavigatorKey;

  CustomRouter() {
    _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  }

  @lazySingleton
  GoRouter get routerConfig => GoRouter(
    initialLocation: RoutePaths.searchYoutube.path,
    // 일단 이렇게 해놓고 나중에 Index페이지 만들기
    navigatorKey: _rootNavigatorKey,
    routes: [..._tripRoutes, ..._youtubeRoutes],
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

  @lazySingleton
  Iterable<GoRoute> get _youtubeRoutes => [
    GoRoute(
      path: RoutePaths.searchYoutube.path,
      builder: (_, __) => const SearchVideosScreen(),
    ),
    GoRoute(
      path: RoutePaths.youtubeDetail.path,
      builder: (_, state) {
        return VideoDetailScreen(state.extra as VideoEntity);
      },
    ),
  ];
}
