import 'package:injectable/injectable.dart';
import 'package:vacation/data/datasources/export.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/repositories/export.dart';

@LazySingleton(as: YoutubeRepository)
class YoutubeRepositoryImpl implements YoutubeRepository {
  final RemoteYoutubeDataSource _remoteDataSource;

  YoutubeRepositoryImpl(this._remoteDataSource);

  @override
  Future<SearchVideoResultEntity> searchVideos(
    String query, {
    String? pageToken,
  }) async {
    return await _remoteDataSource
        .searchVideos(query, pageToken: pageToken)
        .then(SearchVideoResultEntity.from);
  }
}
