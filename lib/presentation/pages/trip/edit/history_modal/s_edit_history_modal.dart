import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/widgets/on_tap_button.dart';
import 'package:vacation/shared/export.dart';

import 'w_description.dart';
import 'w_photos.dart';
import 'w_place_name.dart';
import 'w_visited_at.dart';

class EditHistoryModalScreen extends StatefulWidget {
  const EditHistoryModalScreen({
    super.key,
    this.initialHistory,
    required this.handleSubmit,
    required this.dateRange, // trip date range
    required this.statusStream,
  });

  final HistoryEntity? initialHistory;
  final void Function({
    required String placeName,
    required String description,
    required DateTime visitedAt,
    required List<XFile> images,
    double? latitude,
    double? longitude,
  })
  handleSubmit;
  final DateTimeRange dateRange;
  final Stream<bool> statusStream;

  @override
  State<EditHistoryModalScreen> createState() => _EditHistoryModalScreenState();
}

class _EditHistoryModalScreenState extends State<EditHistoryModalScreen>
    with DateFormatterMixIn, DebounceMixin {
  late final TextEditingController _placeNameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _visitedAtController;
  late List<XFile> _images;
  late StreamSubscription<bool> _subscription;

  @override
  void initState() {
    super.initState();
    _placeNameController =
        TextEditingController()..text = widget.initialHistory?.placeName ?? '';
    _descriptionController =
        TextEditingController()
          ..text = widget.initialHistory?.description ?? '';
    _visitedAtController =
        TextEditingController()
          ..text = handleFormatDateTime(
            widget.initialHistory?.visitedAt ?? DateTime.now(),
          );
    _images = widget.initialHistory?.images.map((e) => XFile(e)).toList() ?? [];
    _subscription = widget.statusStream.listen((v) {
      // 히스토리 수정 이벤트가 성공하는 경우, 모달창 닫기를 실행하기 위해 status필드를 위한 stream
      if (v && context.canPop()) {
        context.pop();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _placeNameController.dispose();
    _descriptionController.dispose();
    _visitedAtController.dispose();
    _subscription.cancel();
  }

  void _setImages(List<XFile> images) {
    setState(() {
      _images = images;
    });
  }

  _handleSubmit() => debounce(() async {
    widget.handleSubmit(
      placeName: _placeNameController.text.trim(),
      description: _descriptionController.text.trim(),
      visitedAt: handleFormatStringToDateTime(_visitedAtController.text.trim()),
      images: _images,
      // TODO : 위치정보 가져오기 기능 구현
      latitude: null,
      longitude: null,
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.initialHistory == null ? "Create History" : "Edit History",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: PlaceNameWidget(_placeNameController),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: DescriptionWidget(_descriptionController),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: VisitedAtWidget(
                controller: _visitedAtController,
                firstDate: widget.dateRange.start,
                lastDate: widget.dateRange.end,
              ),
            ),

            // 사진
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: PhotosWidget(images: _images, setImages: _setImages),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: OnTapButtonWidget(onTap: _handleSubmit),
    );
  }
}
