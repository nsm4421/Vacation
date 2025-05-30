import 'package:flutter/material.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/shared/export.dart';

class HistoryDetailModelFragment extends StatelessWidget
    with DateFormatterMixIn {
  const HistoryDetailModelFragment(this._history, {super.key});

  final HistoryEntity _history;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_history.placeName, overflow: TextOverflow.ellipsis),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.date_range),
                  SizedBox(width: 12),
                  Text(handleFormatDateTime(_history.visitedAt)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.description),
                  SizedBox(width: 12),
                  Text(
                    _history.description,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
