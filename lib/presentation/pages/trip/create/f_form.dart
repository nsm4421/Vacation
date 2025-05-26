import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vacation/presentation/providers/export.dart';

class CreateTripFormFragment extends StatefulWidget {
  const CreateTripFormFragment({super.key});

  @override
  State<CreateTripFormFragment> createState() => _CreateTripFormFragmentState();
}

class _CreateTripFormFragmentState extends State<CreateTripFormFragment> {
  late TextEditingController _tripNameController;
  late TextEditingController _dateRangeController;
  late FocusNode _tripNameFocus;
  late FocusNode _dateRangeFocus;

  @override
  void initState() {
    super.initState();
    _tripNameController =
        TextEditingController()
          ..text = context.read<CreateTripCubit>().state.data.tripName;
    _tripNameFocus = FocusNode()..addListener(_handleTripNameFocus);
    _dateRangeController =
        TextEditingController()
          ..text = _handleFormatDateRange(
            context.read<CreateTripCubit>().state.data.dateRange,
          );
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
      context.read<CreateTripCubit>().updateData(
        tripName: _tripNameController.text.trim(),
      );
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
      initialDateRange: context.read<CreateTripCubit>().state.data.dateRange,
    ).then((selected) {
      if (selected == null || !context.mounted) return;
      _dateRangeController.text = _handleFormatDateRange(selected);
      context.read<CreateTripCubit>().updateData(dateRange: selected);
      FocusScope.of(context).unfocus();
    });
  }

  String _handleFormatDateRange(DateTimeRange range) {
    return '${_handleFormatDateTime(range.start)} ~ ${_handleFormatDateTime(range.end)}';
  }

  String _handleFormatDateTime(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
    );
  }
}
