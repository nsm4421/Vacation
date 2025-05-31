import 'package:flutter/material.dart';

mixin class DateFormatterMixIn {
  String handleFormatDateRange(DateTimeRange range) {
    return '${handleFormatDateTime(range.start)} ~ ${handleFormatDateTime(range.end)}';
  }

  DateTimeRange handleFormatStringToDateTimeRange(String text) {
    return DateTimeRange(
      start: DateTime.parse(text.split('~').first.trim()),
      end: DateTime.parse(text.split('~').last.trim()),
    );
  }

  String handleFormatDateTime(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
  }
}
