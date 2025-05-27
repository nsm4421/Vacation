import 'package:flutter/material.dart';

mixin class DateFormatterMixIn {
  String handleFormatDateRange(DateTimeRange range) {
    return '${handleFormatDateTime(range.start)} ~ ${handleFormatDateTime(range.end)}';
  }

  String handleFormatDateTime(DateTime dt) {
    return "${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}";
  }
}
