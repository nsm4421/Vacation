import 'package:either_dart/either.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';

class SearchVideosUseCase {
  final YoutubeRepository _repository;

  SearchVideosUseCase(this._repository);

  Future<Result<SearchVideoResultEntity>> call(String query, {String? pageToken}) async {
    try {
      return await _repository.searchVideos(query, pageToken:pageToken).then(Right.new);
    } catch (error) {
      return Left(Failure(message: 'fetching fails'));
    }
  }
}
