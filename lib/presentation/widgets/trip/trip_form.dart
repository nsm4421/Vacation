import 'package:flutter/material.dart';
import 'package:vacation/shared/export.dart';

class TripFormWidget extends StatefulWidget {
  const TripFormWidget({
    super.key,
    required this.initialTripName,
    required this.initialDateRange,
    required this.handleUpdateTripName,
    required this.handleUpdateDateRange,
  });

  final String initialTripName;
  final DateTimeRange initialDateRange;
  final void Function(String tripName) handleUpdateTripName;
  final void Function(DateTimeRange dateRange) handleUpdateDateRange;

  @override
  State<TripFormWidget> createState() => _TripFormWidgetState();
}

class _TripFormWidgetState extends State<TripFormWidget>
    with DateFormatterMixIn {
  late final TextEditingController _tripNameController;
  late final TextEditingController _dateRangeController;
  late final FocusNode _tripNameFocus;
  late final FocusNode _dateRangeFocus;

  @override
  void initState() {
    super.initState();
    _tripNameController =
        TextEditingController()..text = widget.initialTripName;
    _tripNameFocus = FocusNode()..addListener(_handleTripNameFocus);
    _dateRangeController =
        TextEditingController()
          ..text = handleFormatDateRange(widget.initialDateRange);
    _dateRangeFocus = FocusNode()..addListener(_handleDateRangeFocus);
  }

  @override
  void dispose() {
    super.dispose();
    _tripNameController.dispose();
    _tripNameFocus
      ..removeListener(_handleTripNameFocus)
      ..dispose();
    _dateRangeController.dispose();
    _dateRangeFocus
      ..removeListener(_handleDateRangeFocus)
      ..dispose();
  }

  _handleTripNameFocus() {
    if (!_tripNameFocus.hasFocus) {
      widget.handleUpdateTripName(_tripNameController.text.trim());
    }
    setState(() {});
  }

  _handleDateRangeFocus() {
    setState(() {});
  }

  _handlePickDateRange() async {
    FocusScope.of(context).unfocus();
    await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDateRange: widget.initialDateRange,
    ).then((selected) {
      if (selected == null || !context.mounted) return;
      _dateRangeController.text = handleFormatDateRange(selected);
      widget.handleUpdateDateRange(selected);
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.title,
              color:
                  _tripNameFocus.hasFocus
                      ? Theme.of(context).colorScheme.primary
                      : null,
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                focusNode: _tripNameFocus,
                controller: _tripNameController,
                decoration: InputDecoration(
                  hintText: "Your Plan Title",
                  isDense: true,
                  border:
                      _tripNameFocus.hasFocus
                          ? OutlineInputBorder()
                          : InputBorder.none,
                ),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(decorationThickness: 0),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.date_range_rounded,
              color:
                  _dateRangeFocus.hasFocus
                      ? Theme.of(context).colorScheme.primary
                      : null,
            ),
            SizedBox(width: 12),
            Expanded(
              child: TextField(
                readOnly: true,
                controller: _dateRangeController,
                focusNode: _dateRangeFocus,
                decoration: InputDecoration(
                  hintText: "Travel Date",
                  suffixIcon: IconButton(
                    onPressed: _handlePickDateRange,
                    icon: Icon(Icons.edit),
                    tooltip: 'Edit',
                  ),
                  border:
                      _dateRangeFocus.hasFocus
                          ? OutlineInputBorder()
                          : InputBorder.none,
                ),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(decorationThickness: 0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
