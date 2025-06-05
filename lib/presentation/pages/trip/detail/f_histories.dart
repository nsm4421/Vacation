import 'package:flutter/material.dart';
import 'package:vacation/domain/entities/export.dart';
import 'package:vacation/presentation/pages/trip/detail/w_carousel.dart';
import 'package:vacation/shared/export.dart';

class HistoriesFragment extends StatelessWidget with DateFormatterMixIn {
  const HistoriesFragment(this._histories, {super.key});

  final List<HistoryEntity> _histories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _histories.length,
      itemBuilder: (context, index) {
        final history = _histories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Row(
                children: [
                  RichText(
                    softWrap: true,
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style, // 기본 스타일 상속
                      children: [
                        TextSpan(
                          text: history.placeName,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: ' (${handleFormatDateTime(history.visitedAt)})',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (history.images.isNotEmpty)
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.width,
                        ),
                        child: CarouselWidget(history.images),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(
                        history.description,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
    ;
  }
}
