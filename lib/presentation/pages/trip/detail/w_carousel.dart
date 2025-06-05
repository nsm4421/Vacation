import 'dart:io';

import 'package:flutter/material.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget(
    this._images, {
    super.key,
    this.maxWidth,
    this.maxHeight,
  });

  final List<String> _images;
  final double? maxWidth;
  final double? maxHeight;

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      pageSnapping: true,
      itemCount: widget._images.length,
      controller: _controller,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final image = widget._images[index];
        return Container(
          width: widget.maxWidth ?? MediaQuery.of(context).size.width,
          height: widget.maxHeight ?? MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(image)),
            ),
          ),
        );
      },
    );
  }
}
