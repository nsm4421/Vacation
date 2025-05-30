import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/shared/export.dart';

class EditTripModalFragment extends StatefulWidget {
  const EditTripModalFragment({
    super.key,
    required this.trip,
    required this.handleCompleteEdit,
  });

  final TripEntity trip;
  final void Function(String title, DateTimeRange dateRange) handleCompleteEdit;

  @override
  State<EditTripModalFragment> createState() => _EditTripModalFragmentState();
}

class _EditTripModalFragmentState extends State<EditTripModalFragment>
    with DateFormatterMixIn, DebounceMixin {
  late final TextEditingController _tripNameController;
  late final TextEditingController _dateRangeController;
  late final FocusNode _tripNameFocus;
  late final FocusNode _dateRangeFocus;
  late DateTimeRange _dateTimeRange;

  @override
  void initState() {
    super.initState();
    _tripNameController = TextEditingController()..text = widget.trip.tripName;
    _tripNameFocus = FocusNode()..addListener(_handleTripNameFocus);
    _dateTimeRange = DateTimeRange(
      start: widget.trip.startDate,
      end: widget.trip.endDate,
    );
    _dateRangeController =
        TextEditingController()..text = handleFormatDateRange(_dateTimeRange);
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
      initialDateRange: _dateTimeRange,
    ).then((selected) {
      if (selected == null || !context.mounted) return;
      setState(() {
        _dateTimeRange = selected;
        _dateRangeController.text = handleFormatDateRange(_dateTimeRange);
      });
      FocusScope.of(context).unfocus();
    });
  }

  _handleSubmit() => debounce(() async {
    FocusScope.of(context).unfocus();
    widget.handleCompleteEdit(_tripNameController.text.trim(), _dateTimeRange);
    if (context.mounted) {
      context.pop();
    }
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("Edit Trip")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
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
                      readOnly: !_tripNameFocus.hasFocus,
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
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
