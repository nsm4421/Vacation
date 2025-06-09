import 'package:flutter/material.dart';
import 'package:vacation/domain/entities/export.dart';

import 'f_video_player.dart';
import 'w_app_bar.dart';

class VideoDetailScreen extends StatelessWidget {
  const VideoDetailScreen(this._video, {super.key});

  final VideoEntity _video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(_video),
      body: VideoPlayerFragment(_video),
    );
  }
}
