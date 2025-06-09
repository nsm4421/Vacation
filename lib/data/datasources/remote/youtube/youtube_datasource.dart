part of 'youtube_datasource_impl.dart';

abstract interface class RemoteYoutubeDataSource {
  Future<SearchVideoResModel> searchVideos(String query, {String? pageToken});
}
