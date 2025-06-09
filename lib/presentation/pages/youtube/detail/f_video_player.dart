import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/widgets/export.dart';

class VideoPlayerFragment extends StatefulWidget {
  const VideoPlayerFragment(this._video, {super.key});

  final VideoEntity _video;

  @override
  State<VideoPlayerFragment> createState() => _VideoPlayerFragmentState();
}

class _VideoPlayerFragmentState extends State<VideoPlayerFragment> {
  late YoutubeExplode yt;
  bool _mounted = false;
  late Uri _uri;

  @override
  void initState() {
    super.initState();
    yt = YoutubeExplode();
    _initStream();
  }

  @override
  dispose() {
    super.dispose();
    yt.close();
  }

  Future<void> _initStream() async {
    try {
      // extract url from video id
      _uri = await yt.videos.streamsClient
          .getManifest(widget._video.videoId)
          .then((manifest) => manifest.videoOnly.withHighestBitrate())
          .then((streamInfo) => streamInfo.url);
    } catch (e) {
      log(e.toString());
    } finally {
      setState(() {
        _mounted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _mounted
        ? ChewieVideoPlayerWidget(_uri)
        : Center(child: CircularProgressIndicator());
  }
}
