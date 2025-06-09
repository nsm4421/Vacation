part of 'search_video.bloc.dart';

@CopyWith(copyWithNull: true)
class SearchVideoState extends AbsBlocState<List<VideoEntity>> {
  SearchVideoState({
    super.status,
    super.message,
    required super.data,
    this.query,
    this.nextPageToken,
  });

  final String? query;
  final String? nextPageToken;

  factory SearchVideoState.initState() {
    return SearchVideoState(data: [], query: null, nextPageToken:null);
  }
}
