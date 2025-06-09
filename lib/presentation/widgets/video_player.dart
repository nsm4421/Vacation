import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ChewieVideoPlayerWidget extends StatefulWidget {
  const ChewieVideoPlayerWidget(this._url, {super.key});

  final Uri _url;

  @override
  State<ChewieVideoPlayerWidget> createState() =>
      _ChewieVideoPlayerWidgetState();
}

class _ChewieVideoPlayerWidgetState extends State<ChewieVideoPlayerWidget> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initStream();
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController?.dispose();
    _videoController?.dispose();
  }

  Future<void> _initStream() async {
    try {
      // initialize video player
      _videoController = VideoPlayerController.networkUrl(widget._url);
      await _videoController!.initialize();
      // initialize chewie player
      _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: false,
      );
      setState(() {});
    } catch (e) {
      log(e.toString());
      setState(() => _isError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return Center(
        child: Text(
          "this video has error",
          style: Theme.of(
            context,
          ).textTheme.displaySmall?.copyWith(overflow: TextOverflow.clip),
          softWrap: true,
        ),
      );
    } else if (_chewieController == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else {
      return Center(child: Chewie(controller: _chewieController!));
    }
  }
}
