part of 'route_config.dart';

enum RoutePaths {
  signIn('/auth/sign-in', isAuth: true),
  signUp('/auth/sign-up', isAuth: true),
  entry('/'),
  displayTrips('/trip'),
  createTrips('/trip/create');

  final String path;
  final bool isAuth;

  const RoutePaths(this.path, {this.isAuth = false});
}