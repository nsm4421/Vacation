import 'package:injectable/injectable.dart';
import 'package:vacation/domain/repositories/export.dart';
import 'package:vacation/shared/export.dart';
import 'scenario/search_video.dart';

@lazySingleton
class YoutubeUseCase with LoggerMixIn {
  final YoutubeRepository _repository;

  YoutubeUseCase(this._repository);

  SearchVideosUseCase get search => SearchVideosUseCase(_repository);
}
