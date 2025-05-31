import 'dart:io';

import 'package:flutter/material.dart';

class CircularAvatarImageWidget extends StatelessWidget {
  const CircularAvatarImageWidget({
    super.key,
    this.imagePath,
    this.text,
    this.radius = 20,
  });

  final String? imagePath;
  final String? text;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return CircleAvatar(
        maxRadius: radius,
        backgroundImage: FileImage(File(imagePath!)),
      );
    } else if (text != null) {
      CircleAvatar(maxRadius: radius, child: Text(text!));
    }
    return SizedBox.shrink();
  }
}
