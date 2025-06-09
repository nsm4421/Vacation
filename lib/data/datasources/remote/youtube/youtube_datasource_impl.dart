import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:vacation/data/models/export.dart';
import 'package:vacation/env.dart';

part 'youtube_datasource.dart';

class RemoteYoutubeDataSourceImpl implements RemoteYoutubeDataSource {
  final Dio _dio;
  final Logger? _logger;

  RemoteYoutubeDataSourceImpl(this._dio, {Logger? logger}) : _logger = logger;

  @override
  Future<SearchVideoResModel> searchVideos(
    String query, {
    String? pageToken,
  }) async {
    final endPoint = 'https://www.googleapis.com/youtube/v3/search';
    final params = {
      ...SearchVideoReqModel(q: query).toJson(),
      'key': Env.youtubeApiKey,
      if (pageToken != null) 'pageToken': pageToken,
    };
    return await _dio
        .get(endPoint, queryParameters: params)
        .then((res) => (res.data as Map<String, dynamic>))
        .then(SearchVideoResModel.fromJson)
        .then((res) {
          _logger?.t(
            'next page token :${res.nextPageToken}\n'
            'fetched:${res.pageInfo.resultsPerPage}\n'
            'totalResult:${res.pageInfo.totalResults}',
          );
          return res;
        });
  }
}
