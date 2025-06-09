import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:vacation/data/models/export.dart';

part 'video.g.dart';

@CopyWith()
class SearchVideoResultEntity {
  final List<VideoEntity> videos;
  final String? nextPageToken;

  SearchVideoResultEntity({required this.videos, this.nextPageToken});

  factory SearchVideoResultEntity.from(SearchVideoResModel model) =>
      SearchVideoResultEntity(
        videos:
            model.videos
                .map(
                  (e) => VideoEntity(
                    title: e.title,
                    thumbnail: e.thumbnail,
                    videoId: e.videoId,
                    publishTime: DateTime.tryParse(e.publishTime),
                  ),
                )
                .toList(),
        nextPageToken: model.nextPageToken,
      );
}

@CopyWith()
class VideoEntity {
  final String title;
  final String thumbnail;
  final String videoId;
  final DateTime? publishTime;

  VideoEntity({
    required this.title,
    required this.thumbnail,
    required this.videoId,
    this.publishTime,
  });
}
