import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/shared/export.dart';

class SelectImageWidget extends StatefulWidget {
  const SelectImageWidget({
    super.key,
    required this.trip,
    required this.currentImage,
    required this.updateImage,
  });

  final TripEntity trip;
  final XFile? currentImage;
  final void Function(XFile? xFile) updateImage;

  @override
  State<SelectImageWidget> createState() => _SelectImageWidgetState();
}

class _SelectImageWidgetState extends State<SelectImageWidget> {
  late ImagePicker _imagePicker;
  late XFile? _initialImage;
  static const double _thumbnailPreviewSize = 200;

  @override
  initState() {
    super.initState();
    _imagePicker = ImagePicker();
    _initialImage =
        widget.trip.thumbnail == null ? null : XFile(widget.trip.thumbnail!);
  }

  _handleSelectImage() async {
    context.unfocus();
    final selected = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (selected == null || !context.mounted) return;
    widget.updateImage(selected);
  }

  _handleResetImage() {
    widget.updateImage(_initialImage);
  }

  _handleUnSelectImage() {
    widget.updateImage(null);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.photo_size_select_actual_outlined),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.currentImage == null
                        ? 'No Thumbnail Selected'
                        : 'Thumbnail Selected',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Spacer(),

                  IconButton(
                    onPressed: _handleResetImage,
                    icon: Icon(Icons.rotate_left),
                    tooltip: 'Reset Thumbnail',
                  ), // 썸네일 리셋버튼
                  SizedBox(width: 6),
                  IconButton(
                    onPressed:
                        widget.currentImage == null
                            ? _handleSelectImage
                            : _handleUnSelectImage,
                    icon: Icon(
                      widget.currentImage == null
                          ? Icons.add_circle_outline
                          : Icons.delete_outline,
                    ),
                    tooltip:
                        widget.currentImage == null
                            ? 'Select Thumbnail'
                            : 'UnSelect Thumbnail',
                  ), // 썸네일 추가 및 삭제 버튼
                ],
              ),
              if (widget.currentImage != null)
                SizedBox(
                  width: _thumbnailPreviewSize,
                  height: _thumbnailPreviewSize,
                  child: GestureDetector(
                    onTap: _handleSelectImage,
                    child: Container(
                      width: _thumbnailPreviewSize,
                      height: _thumbnailPreviewSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(widget.currentImage!.path)),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
    ;
  }
}
