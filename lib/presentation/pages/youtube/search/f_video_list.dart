import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/pages/export.dart';
import 'package:vacation/presentation/pages/youtube/search/w_fetch_more_button.dart';
import 'package:vacation/shared/export.dart';

class VideoListFragment extends StatelessWidget with DateFormatterMixIn {
  const VideoListFragment(this._videos, {super.key});

  final List<VideoEntity> _videos;

  @override
  Widget build(BuildContext context) {
    return _videos.isEmpty
        ? Center(
          child: Text(
            'nothing to show',
            style: Theme.of(context).textTheme.displaySmall,
            softWrap: true,
          ),
        )
        : ListView.builder(
          shrinkWrap: true,
          itemCount: _videos.length + 1,
          itemBuilder: (context, index) {
            if (index == _videos.length) {
              // 마지막은 더 가져오기 버튼
              return FetchMoreButtonWidget();
            }
            final e = _videos[index];
            return ListTile(
              onTap: () async {
                await context.push(RoutePaths.youtubeDetail.path, extra: e);
              },
              leading: CachedNetworkImage(
                imageUrl: e.thumbnail,
                placeholder:
                    (context, url) => Transform.scale(
                      scale: 0.5,
                      child: CircularProgressIndicator(),
                    ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
              title: Text(e.title),
              subtitle:
                  e.publishTime == null
                      ? null
                      : Text(handleFormatDateTime(e.publishTime!)),
            );
          },
        );
  }
}
