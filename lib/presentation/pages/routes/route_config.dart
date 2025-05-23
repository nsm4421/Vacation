import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:go_router/go_router.dart';

import '../index/index.screen.dart';

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
    routes: [
      GoRoute(
        // 시작 페이지
        path: RoutePaths.entry.path,
        builder: (_, __) => const IndexScreen(),
      ),
    ],
  );
}
