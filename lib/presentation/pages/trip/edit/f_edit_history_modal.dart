import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/shared/export.dart';

class EditHistoryModalFragment extends StatefulWidget {
  const EditHistoryModalFragment({
    super.key,
    this.initialHistory,
    required this.handleSubmit,
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

  @override
  State<EditHistoryModalFragment> createState() =>
      _EditHistoryModalFragmentState();
}

class _EditHistoryModalFragmentState extends State<EditHistoryModalFragment>
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
    await showDatePicker(
      context: context,
      currentDate: _visitedAt,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
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
    if (context.mounted) {
      context.pop();
    }
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 12),
                    child: Icon(Icons.location_city_outlined),
                  ),
                  Expanded(
                    child: TextField(
                      maxLength: 30,
                      controller: _placeNameController,
                      decoration: InputDecoration(
                        hintText: 'Place Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 12),
                    child: Icon(Icons.description),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _descriptionController,
                      minLines: 3,
                      maxLines: 10,
                      maxLength: 1000,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, right: 12),
                    child: Icon(Icons.date_range_outlined),
                  ),
                  Expanded(
                    child: TextField(
                      onTap: _handleSelectDate,
                      controller: _visitedAtController,
                      readOnly: true,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        onPressed: _handleSubmit,
        child: Text(
          "SUBMIT",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
