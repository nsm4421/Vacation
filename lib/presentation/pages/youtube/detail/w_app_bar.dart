import 'package:flutter/material.dart';
import 'package:vacation/domain/entities/export.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget(this._video, {super.key});

  final VideoEntity _video;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_video.title, overflow: TextOverflow.ellipsis),
      actions: [
        IconButton(
          onPressed: () {
            // TODO : 다운로드 기능
          },
          icon: Icon(Icons.download),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
