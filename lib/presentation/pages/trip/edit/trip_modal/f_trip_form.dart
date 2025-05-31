import 'package:flutter/material.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/shared/export.dart';

class TripFormFragment extends StatefulWidget {
  const TripFormFragment({
    super.key,
    required this.formKey,
    required this.trip,
    required this.tripNameController,
    required this.dateRangeController,
  });

  final GlobalKey<FormState> formKey;
  final TripEntity trip;
  final TextEditingController tripNameController;
  final TextEditingController dateRangeController;

  @override
  State<TripFormFragment> createState() => _TripFormFragmentState();
}

class _TripFormFragmentState extends State<TripFormFragment>
    with DateFormatterMixIn, DebounceMixin {
  late final FocusNode _tripNameFocus;
  late final FocusNode _dateRangeFocus;

  @override
  void initState() {
    super.initState();
    _tripNameFocus = FocusNode()..addListener(_handleTripNameFocus);
    _dateRangeFocus = FocusNode()..addListener(_handleDateRangeFocus);
  }

  @override
  void dispose() {
    super.dispose();
    _tripNameFocus
      ..removeListener(_handleTripNameFocus)
      ..dispose();
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

  String? _handleValidateTitle(String? text) {
    if (text == null || text.isEmpty) {
      return 'title is not given';
    }
    return null;
  }

  String? _handleValidateDateRange(String? text) {
    try {
      handleFormatStringToDateTimeRange(widget.dateRangeController.text);
    } catch (error) {
      return 'not valid date range';
    }
    return null;
  }

  _handlePickDateRange() async {
    context.unfocus();
    await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDateRange: widget.trip.dateRange,
    ).then((selected) {
      if (selected == null || !context.mounted) return;
      setState(() {
        widget.dateRangeController.text = handleFormatDateRange(selected);
      });
      context.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
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
                child: TextFormField(
                  validator: _handleValidateTitle,
                  readOnly: !_tripNameFocus.hasFocus,
                  focusNode: _tripNameFocus,
                  controller: widget.tripNameController,
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
                child: TextFormField(
                  validator: _handleValidateDateRange,
                  readOnly: true,
                  controller: widget.dateRangeController,
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
      ),
    );
  }
}
