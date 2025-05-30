import 'package:flutter/material.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/shared/export.dart';

class TripInfoWidget extends StatelessWidget with DateFormatterMixIn {
  const TripInfoWidget(this._trip, {super.key, this.onClickEditButton});

  final TripEntity _trip;
  final void Function()? onClickEditButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Trip',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            if (onClickEditButton != null)
              IconButton(
                onPressed: onClickEditButton,
                icon: Icon(Icons.edit_outlined),
                tooltip: 'Edit',
              ),
          ],
        ),
        SizedBox(height: 12),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.title),
                    SizedBox(width: 16),
                    Text(
                      _trip.tripName,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined),
                    SizedBox(width: 16),
                    Text(
                      '${handleFormatDateTime(_trip.startDate)}~${handleFormatDateTime(_trip.endDate)}',
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
