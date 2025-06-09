part of 'route_config.dart';

enum RoutePaths {
  searchYoutube('/youtube/search'),
  youtubeDetail('/youtube/detail'),
  displayTrips('/trip'),
  createTrip('/trip/create'),
  editTrip('/trip/edit'),
  tripDetail('/trip/detail');

  final String path;

  const RoutePaths(this.path);
}
