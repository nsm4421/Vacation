import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vacation/shared/export.dart';

class PhotosWidget extends StatefulWidget {
  const PhotosWidget({
    super.key,
    required this.images,
    required this.setImages,
  });

  final List<XFile> images;
  final void Function(List<XFile> images) setImages;

  @override
  State<PhotosWidget> createState() => _PhotosWidgetState();
}

class _PhotosWidgetState extends State<PhotosWidget> {
  late final ImagePicker _imagePicker;
  static const int _maxCount = 6;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  _handleSelectImage() async {
    await _imagePicker.pickMultiImage().then((res) {
      final totalCnt = widget.images.length + res.length;
      if (totalCnt > _maxCount) {
        context.showErrorSnackBar("number of image can't be exceed $_maxCount");
      }
      widget.setImages([...widget.images, ...res].take(_maxCount).toList());
    });
  }

  _handleUnSelectImage(int index) => () {
    List<XFile> images = [...widget.images];
    images.removeAt(index);
    widget.setImages(images);
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.add_photo_alternate_outlined, size: 16),
            SizedBox(width: 8),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  TextSpan(
                    text: 'Photo ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: '(${widget.images.length}/$_maxCount)',
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: Colors.blueGrey),
                  ),
                ],
              ),
            ),
            Spacer(),
            if (widget.images.length < _maxCount)
              IconButton(
                onPressed: _handleSelectImage,
                icon: Icon(Icons.add_circle_outline),
              ),
          ],
        ),
        SizedBox(height: 8),

        if (widget.images.isNotEmpty)
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.width,
            ),
            child: CustomScrollView(
              slivers: [
                SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image:
                            index < widget.images.length
                                ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                    File(widget.images[index].path),
                                  ),
                                )
                                : null,
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              onPressed: _handleUnSelectImage(index),
                              icon: Icon(Icons.remove_circle_outline),
                            ),
                          ),
                        ],
                      ),
                    );
                  }, childCount: widget.images.length),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
