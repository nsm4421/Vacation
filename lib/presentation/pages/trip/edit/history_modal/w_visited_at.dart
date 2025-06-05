import 'package:flutter/material.dart';
import 'package:vacation/shared/export.dart';

class VisitedAtWidget extends StatefulWidget {
  const VisitedAtWidget({
    super.key,
    required this.controller,
    required this.firstDate,
    required this.lastDate,
  });

  final TextEditingController controller;
  final DateTime firstDate;
  final DateTime lastDate;

  @override
  State<VisitedAtWidget> createState() => _VisitedAtWidgetState();
}

class _VisitedAtWidgetState extends State<VisitedAtWidget>
    with DateFormatterMixIn {
  late DateTime _visitedAt;

  @override
  initState() {
    super.initState();
    _visitedAt = handleFormatStringToDateTime(widget.controller.text);
  }

  Future<void> _handleSelectDate() async {
    context.unfocus();
    await showDatePicker(
      context: context,
      currentDate: _visitedAt,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    ).then((selected) {
      if (selected == null || !context.mounted) return;
      setState(() {
        _visitedAt = selected;
        widget.controller.text = handleFormatDateTime(_visitedAt);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.date_range_outlined, size: 16),
            SizedBox(width: 8),
            Text(
              'Visited At',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SizedBox(height: 8),
        TextField(
          onTap: _handleSelectDate,
          minLines: 1,
          maxLines: 1,
          readOnly: true,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: 'How was it?',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
