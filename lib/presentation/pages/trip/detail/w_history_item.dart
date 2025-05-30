import 'package:flutter/material.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/pages/trip/detail/f_history_deatil_modal.dart';
import 'package:vacation/shared/export.dart';

class HistoryItemWidget extends StatelessWidget with DateFormatterMixIn {
  const HistoryItemWidget(this._history, {super.key});

  final HistoryEntity _history;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (context) {
            return HistoryDetailModelFragment(_history);
          },
        );
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    _history.placeName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  Text(
                    handleFormatDateTime(_history.visitedAt),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  _history.description,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
