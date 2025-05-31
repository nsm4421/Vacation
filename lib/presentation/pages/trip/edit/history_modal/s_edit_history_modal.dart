import 'package:flutter/material.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/widgets/on_tap_button.dart';
import 'package:vacation/shared/export.dart';

class EditHistoryModalScreen extends StatefulWidget {
  const EditHistoryModalScreen({
    super.key,
    this.initialHistory,
    required this.handleSubmit,
    required this.dateRange,
  });

  final HistoryEntity? initialHistory;
  final void Function({
    required String placeName,
    required String description,
    required DateTime visitedAt,
    double? latitude,
    double? longitude,
  })
  handleSubmit;
  final DateTimeRange dateRange;

  @override
  State<EditHistoryModalScreen> createState() =>
      _EditHistoryModalScreenState();
}

class _EditHistoryModalScreenState extends State<EditHistoryModalScreen>
    with DateFormatterMixIn, DebounceMixin {
  late final TextEditingController _placeNameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _visitedAtController;
  late DateTime _visitedAt;

  @override
  void initState() {
    super.initState();
    _placeNameController =
        TextEditingController()..text = widget.initialHistory?.placeName ?? '';
    _descriptionController =
        TextEditingController()
          ..text = widget.initialHistory?.description ?? '';
    _visitedAt = widget.initialHistory?.visitedAt ?? DateTime.now();
    _visitedAtController =
        TextEditingController()..text = handleFormatDateTime(_visitedAt);
  }

  @override
  void dispose() {
    super.dispose();
    _placeNameController.dispose();
    _descriptionController.dispose();
    _visitedAtController.dispose();
  }

  _handleSelectDate() async {
    context.unfocus();
    await showDatePicker(
      context: context,
      currentDate: _visitedAt,
      firstDate: widget.dateRange.start,
      lastDate: widget.dateRange.end,
    ).then((selected) {
      if (selected == null || !context.mounted) return;
      setState(() {
        _visitedAt = selected;
        _visitedAtController.text = handleFormatDateTime(_visitedAt);
      });
    });
  }

  _handleSubmit() => debounce(() async {
    widget.handleSubmit(
      placeName: _placeNameController.text.trim(),
      description: _descriptionController.text.trim(),
      visitedAt: _visitedAt,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_city_outlined, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Place Name',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  TextField(
                    minLines: 1,
                    maxLines: 1,
                    maxLength: 30,
                    controller: _placeNameController,
                    decoration: InputDecoration(
                      hintText: 'Where did you go?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.description, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  TextField(
                    minLines: 3,
                    maxLines: 10,
                    maxLength: 1000,
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: 'How was it?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.date_range_outlined, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Visited At',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  TextField(
                    onTap: _handleSelectDate,
                    minLines: 1,
                    maxLines: 1,
                    readOnly: true,
                    controller: _visitedAtController,
                    decoration: InputDecoration(
                      hintText: 'How was it?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: OnTapButtonWidget(onTap: _handleSubmit),
    );
  }
}
