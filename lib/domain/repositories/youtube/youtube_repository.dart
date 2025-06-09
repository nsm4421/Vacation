import 'package:vacation/domain/entities/export.dart';

abstract interface class YoutubeRepository {
  Future<SearchVideoResultEntity> searchVideos(String query, {String? pageToken});
}