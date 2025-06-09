import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vacation/shared/export.dart';

part 'search_video.freezed.dart';

part 'search_video.g.dart';

@freezed
@JsonSerializable()
class SearchVideoReqModel with _$SearchVideoReqModel {
  SearchVideoReqModel({
    this.part = 'snippet',
    required this.q,
    this.type = VideoType.video,
    this.maxResults = 20,
  });

  final String part;
  final String q;
  final VideoType type;
  final int maxResults;

  factory SearchVideoReqModel.fromJson(Map<String, dynamic> json) =>
      _$SearchVideoReqModelFromJson(json);

  Map<String, Object?> toJson() => _$SearchVideoReqModelToJson(this);
}

@freezed
@JsonSerializable()
class SearchVideoResModel with _$SearchVideoResModel {
  SearchVideoResModel({
    this.nextPageToken,
    required this.pageInfo,
    required this.items,
  });

  final List<$Item> items;
  final String? nextPageToken;
  final $PageInfo pageInfo;

  List<VideoModel> get videos =>
      items
          .where((e) => e.id?.videoId != null)
          .map(
            (e) => VideoModel(
              title: e.snippet.title,
              thumbnail: e.snippet.defaultThumbnail,
              videoId: e.id!.videoId!,
              publishTime: e.snippet.publishTime,
            ),
          )
          .toList();

  factory SearchVideoResModel.fromJson(Map<String, dynamic> json) =>
      _$SearchVideoResModelFromJson(json);
}

@freezed
@JsonSerializable()
class VideoModel with _$VideoModel {
  final String title;
  final String thumbnail;
  final String videoId;
  final String publishTime;

  VideoModel({
    required this.title,
    required this.thumbnail,
    required this.videoId,
    required this.publishTime,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);

  Map<String, Object?> toJson() => _$VideoModelToJson(this);
}

@freezed
@JsonSerializable()
class $Item with _$$Item {
  $Item({this.kind, this.etag, this.id, required this.snippet});

  final String? kind;
  final String? etag;
  final $Id? id;
  final $Snippet snippet;

  factory $Item.fromJson(Map<String, dynamic> json) => _$$ItemFromJson(json);
}

@freezed
@JsonSerializable()
class $PageInfo with _$$PageInfo {
  $PageInfo({this.totalResults = 0, this.resultsPerPage = 0});

  final int totalResults;
  final int resultsPerPage;

  factory $PageInfo.fromJson(Map<String, dynamic> json) =>
      _$$PageInfoFromJson(json);
}

@freezed
@JsonSerializable()
class $Snippet with _$$Snippet {
  final String publishedAt;
  final String channelId;
  final String title;
  final Map<String, dynamic> thumbnails;
  final String channelTitle;
  final String liveBroadcastContent;
  final String publishTime;

  $Snippet({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.thumbnails,
    required this.channelTitle,
    required this.liveBroadcastContent,
    required this.publishTime,
  });

  String get defaultThumbnail => this.thumbnails['default']['url'];

  factory $Snippet.fromJson(Map<String, dynamic> json) =>
      _$$SnippetFromJson(json);
}

@freezed
@JsonSerializable()
class $Id with _$$Id {
  final String kind;
  final String? channelId;
  final String? videoId;

  $Id({required this.kind, this.channelId, this.videoId});

  factory $Id.fromJson(Map<String, dynamic> json) => _$$IdFromJson(json);
}
