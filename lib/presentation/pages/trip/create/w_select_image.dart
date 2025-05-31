import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vacation/presentation/providers/export.dart';
import 'package:vacation/shared/export.dart';

class SelectImageWidget extends StatefulWidget {
  const SelectImageWidget({super.key});

  @override
  State<SelectImageWidget> createState() => _SelectImageWidgetState();
}

class _SelectImageWidgetState extends State<SelectImageWidget> {
  late final ImagePicker _imagePicker;

  static const double _thumbnailPreviewSize = 200;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  _handleSelectImage() async {
    context.unfocus();
    final selected = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (selected == null || !context.mounted) return;
    context.read<CreateTripCubit>().selectThumbnail(selected);
  }

  _handleUnSelect() {
    context.read<CreateTripCubit>().unSelectThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTripCubit, CreateTripState>(
      builder: (context, state) {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.data.thumbnail == null
                            ? 'No Thumbnail Selected'
                            : 'Thumbnail Selected',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      IconButton(
                        onPressed:
                            state.data.thumbnail == null
                                ? _handleSelectImage
                                : _handleUnSelect,
                        icon: Icon(
                          state.data.thumbnail == null
                              ? Icons.add_circle_outline
                              : Icons.rotate_left,
                        ),
                        tooltip:
                            state.data.thumbnail == null
                                ? 'Select Thumbnail'
                                : 'UnSelect Thumbnail',
                      ),
                    ],
                  ),
                  if (state.data.thumbnail != null)
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
                              image: FileImage(
                                File(state.data.thumbnail!.path),
                              ),
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
      },
    );
  }
}
